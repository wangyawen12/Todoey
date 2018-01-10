//
//  ViewController.swift
//  Todoey
//
//  Created by Yawen Wang on 1/4/18.
//  Copyright © 2018 Yawen Wang. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
    
        
        
    }
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("call for ROWatindexpath called")
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        if item.done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }

        return cell
        
    }
        

    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return itemArray.count
//        }

    
        
    //MARK - Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //print(itemArray[indexPath.row])
        
        //itemArray.remove(at: indexPath.row)

       // itemArray[indexPath.row].setValue("completed", forKey: "title")
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        
      saveItems()
       
      tableView.deselectRow(at: indexPath, animated: true)
   
    
    }
    
        
   //Mark -Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
  
    var textField = UITextField()
        
    let alert = UIAlertController(title: "Add New Todo Item", message: " ", preferredStyle: .alert)

    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
       // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
        
        let newItem = Item(context: self.context)
        
        newItem.title = textField.text!
        newItem.done = false
        newItem.parentCategory = self.selectedCategory
        
        
        self.itemArray.append(newItem)
        
        self.saveItems()
        
        }
    
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            
            textField = alertTextField
            
//            self.itemArray.append(text)
//            self.tableView.reloadData()
       }
    
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    
}

//MARK - Model manipilation methods
    func saveItems(){
        
        
        do{
            try context.save()
            
        } catch{
            print("Error saving context\(error)")
        }
        
        self.tableView.reloadData()
        
  
    }

    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(),predicate: NSPredicate? = nil){
        
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            
        }else{
            request.predicate = categoryPredicate
        }
        

      
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context\(error)")
        }
    

        tableView.reloadData()
    }
    
}

 //Mark: - Search bar methods

extension TodoListViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {


        let request : NSFetchRequest<Item> =  Item.fetchRequest()

        

        let predicate = NSPredicate(format: "title CONTAINS[cd]  %@", searchBar.text!)



        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]


        loadItems(with: request,predicate: predicate)
        
        
    }


        //tableView.reloadData()

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){

            if searchBar.text?.count == 0 {

                loadItems()


                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }

            }




    }




}






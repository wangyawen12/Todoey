//
//  ViewController.swift
//  Todoey
//
//  Created by Yawen Wang on 1/4/18.
//  Copyright © 2018 Yawen Wang. All rights reserved.
//

import UIKit
import RealmSwift


class TodoListViewController: UITableViewController {

    var todoItems:Results<Item>?
    let realm = try! Realm()
    
    
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
        return todoItems?.count ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("call for ROWatindexpath called")
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]{
            
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else{
            cell.textLabel?.text = "No Items Added"
        }
        
       
        
//
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }

        return cell
        
    }
        

    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return itemArray.count
//        }

    
        
    //MARK - Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            
            do{
                try realm.write {
                    item.done = !item.done
            }
            }catch{
                print("Error saving done status,\(error)")
            }
        }
        
        
        tableView.reloadData()
        
      
       
      tableView.deselectRow(at: indexPath, animated: true)
   
    
    }
    
        
   //Mark -Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
  
    var textField = UITextField()
        
    let alert = UIAlertController(title: "Add New Todo Item", message: " ", preferredStyle: .alert)

    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
       // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
        if let currentCategory = self.selectedCategory{
            
            do{
            try self.realm.write {
                let newItem = Item()
                
                newItem.title = textField.text!
                newItem.dateCreated = Date()
                
                currentCategory.items.append(newItem)
            }
            
            }catch{
                print("Error saving new items,\(error)")
            }
            
        }
       
        self.tableView.reloadData()
        
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
//    func saveItems(){
//
//
//        do{
//            try context.save()
//
//        } catch{
//            print("Error saving context\(error)")
//        }
//
//        self.tableView.reloadData()
//
//
//    }

    func loadItems(){

        
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)



        tableView.reloadData()
    }

}

 //Mark: - Search bar methods

extension TodoListViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        
        todoItems = todoItems?.filter("title CONTAINS[cd]  %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }
//        let request : NSFetchRequest<Item> =  Item.fetchRequest()
//
//
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd]  %@", searchBar.text!)
//
//
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//
//        loadItems(with: request,predicate: predicate)





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






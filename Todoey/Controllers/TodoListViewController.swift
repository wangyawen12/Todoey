//
//  ViewController.swift
//  Todoey
//
//  Created by Yawen Wang on 1/4/18.
//  Copyright © 2018 Yawen Wang. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class TodoListViewController: SwipeTableViewController {

    var todoItems:Results<Item>?
    let realm = try! Realm()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.separatorStyle = .none
        

        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
         title = selectedCategory!.name
        
      
         guard  let colorHex = selectedCategory?.color else{ fatalError()  }
            
        
           updateNavBar(withHexCode: colorHex)
        
                

        
    }
    
    override  func viewWillDisappear(_ animated: Bool){
       updateNavBar(withHexCode: "76D6FF")
        

    }
    
    //MARK: - Nav Bar Setup Methods
    
    func updateNavBar(withHexCode  colorHexCode: String){
        
         guard let navBar = navigationController?.navigationBar else{fatalError("Navigation controller does not exist")}
        
        
       guard  let navBarColor = UIColor(hexString:colorHexCode) else {   fatalError()}
        //let navBarColor = FlatWhite()
        
        navBar.barTintColor = navBarColor
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
        
        
        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor :ContrastColorOf(navBarColor, returnFlat: true)]
        searchBar.barTintColor = navBarColor
        
        
        
    }
    
    
    
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("call for ROWatindexpath called")
       
    
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row]{
            
            
            cell.textLabel?.text = item.title
            
            
            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage:
                
                CGFloat(indexPath.row)/CGFloat(todoItems!.count)){
                    
                    cell.backgroundColor = color
                
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                    
                    }
            
          
        
            
        
            
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
    
    
    //MARK: - Delete Dta From Swipe
    
    override func updateModel(at indexPath: IndexPath) {

        if let itemforDeletion = todoItems?[indexPath.row]{

            do{
                try realm.write {
                    realm.delete(itemforDeletion)
                }

            }catch{
                print("Error deleting category,\(error)")
            }



        }

        
        
        
    }
    

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






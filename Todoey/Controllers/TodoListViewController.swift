//
//  ViewController.swift
//  Todoey
//
//  Created by Yawen Wang on 1/4/18.
//  Copyright © 2018 Yawen Wang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
//        let newItem = Item()
//        newItem.title = "food"
//        itemArray.append(newItem)
//
//        let newItem1 = Item()
//        newItem1.title = "drink"
//        itemArray.append(newItem1)
//
//        let newItem2 = Item()
//        newItem2.title = "cosmetics"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "study"
//        itemArray.append(newItem3)
//
//        let newItem4 = Item()
//        newItem4.title = "snacks"
//        itemArray.append(newItem4)
        
//        if let items = defaults.array(forKey: "TodoListArray") as?[Item]{
//            itemArray = items
//        }
        
        loadItems()
        
        
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
        
        //itemArray[indexPath.row].done=!itemArray[indexPath.row].done
        
        if itemArray[indexPath.row].done == false{
            itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }
        
        
      self.saveItems()
       
      tableView.deselectRow(at: indexPath, animated: true)
   
    
    }
    
        
   //Mark -Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
  
    var textField = UITextField()
        
    let alert = UIAlertController(title: "Add New Todo Item", message: " ", preferredStyle: .alert)

    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
       
        
        let newItem = Item()
        newItem.title = textField.text!
        
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
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
        } catch{
            print("Error encoding item array,\(error)")
        }
        
        self.tableView.reloadData()
        
  
    }

    func loadItems(){
        if let data = try?Data(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
            
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            } catch{
                    print("Error decoding item array,\(error)")
            }
 
        }

  }

}

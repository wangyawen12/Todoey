//
//  ViewController.swift
//  Todoey
//
//  Created by Yawen Wang on 1/4/18.
//  Copyright © 2018 Yawen Wang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    var itemArray = ["fruit and vegetables", "cosmetics","study stuff"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let items = defaults.array(forKey: "TodoListArray") as?[String]{
            itemArray = items
        }
        
    }
    //MARK - Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        

        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
        
    }
        

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
        }

    
        
    //MARK - Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
      // tableView.deselectRow(at: indexPath, animated: true)
   
    
    }
    
        
   //Mark -Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
  
    var textField = UITextField()
        
    let alert = UIAlertController(title: "Add New Todo Item", message: " ", preferredStyle: .alert)

    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
       
        self.itemArray.append(textField.text!)
        
        self.defaults.set(self.itemArray, forKey: "TodoListArray")
        
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



}

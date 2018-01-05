//
//  ViewController.swift
//  Todoey
//
//  Created by Yawen Wang on 1/4/18.
//  Copyright © 2018 Yawen Wang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    let itemArray = ["fruit and vegetables", "cosmetics","study stuff"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
        
        
    
}




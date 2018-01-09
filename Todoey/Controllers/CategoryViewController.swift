//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Yawen Wang on 1/8/18.
//  Copyright © 2018 Yawen Wang. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    
    var categoryArray = [Category]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


   
    
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    
    
    //MARK: - Data Manipulation Methods
    
    
    
    
    
    
    
    //MARK: - Add New Categories
//    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//        var textField = UITextField()
//
//        let categoryAlert = UIAlertController(title: "Add New Todo Catery", message: " ", preferredStyle: .alert)
//
//        let categoryAction = UIAlertAction(title: "Add Category", style: .default) { (action) in
//
//            // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//
//           let newCategory = Item(context: self.context)
//
//            newCategory = textField.text!
//
//            newCategory.done = false
//
//            self.CategoryArray.append(newCategory)
//
//            //self.saveItems()
//
//        }
//
//        categoryAlert.addTextField { (alertTextField) in
//            categoryAlertTextField.placeholder = "Create new category"
//
//
//            textField = categoryAlertTextField
//
//            //            self.itemArray.append(text)
//            //            self.tableView.reloadData()
//        }
//        
//        categoryAlert.addAction(action)
//        present(categoryAlert,animated: true, completion: nil)
//
//
//    }
    
    
    //MARK: - TableView Delegate Methods
    
   
    
    
    
    
    
    
}

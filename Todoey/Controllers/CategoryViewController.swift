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

    
    var categories = [Category]()
    
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//

        loadCategories()

        
    }


   
    
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("call for ROWatindexpath called")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
       
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        
        return cell
        
    }
    
    
    
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories(){


        do{
            try context.save()

        } catch{
            print("Error saving context\(error)")
        }

        self.tableView.reloadData()


    }

    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()

        do{
            categories = try context.fetch(request)
        }catch{
            print("Error loading categories \(error)")
        }


        tableView.reloadData()
    }




    
    
    
    
    
    //MARK: - Add New Categories
    

    
    @IBAction func addCategoryButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
//            self.categoryArray.append(textField.text!)
//
//            self.tableView.reloadData()
//
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
           // newItem.done = false
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        
        alert.addTextField { (field) in
            textField.placeholder = "Add a new category"
            textField = field
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
    
    
    
}

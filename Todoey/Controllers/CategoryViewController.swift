//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Yawen Wang on 1/8/18.
//  Copyright © 2018 Yawen Wang. All rights reserved.
//

import UIKit

import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//

        loadCategories()

        
    }


   
    
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("call for ROWatindexpath called")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
       
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        
        return cell
        
    }
    
    
    
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category){


        do{
            try realm.write {
                realm.add(category)
            }

        } catch{
            print("Error saving context\(error)")
        }

        self.tableView.reloadData()


    }

    func loadCategories(){
        
        
         categories = realm.objects(Category.self)
        
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
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
           // newItem.done = false
            
           
            
            self.save(category: newCategory)
            
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
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    
    
    
}

//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Yawen Wang on 1/8/18.
//  Copyright © 2018 Yawen Wang. All rights reserved.
//

import UIKit

import RealmSwift

import ChameleonFramework



class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//

        loadCategories()
        tableView.separatorStyle = .none
        
    }


   
    
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("call for ROWatindexpath called")
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row]{
            
            cell.textLabel?.text = category.name
            
            
//
//            cell.backgroundColor = UIColor(hexString: category.color)
//
//            cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: category.color)!, returnFlat: true)
            
            guard let categoryColor = UIColor(hexString: category.color) else{fatalError()}
            
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor,returnFlat: true)
        
        
        }
        
        
        
        
        
        
        
//        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
//
//        cell.backgroundColor = UIColor(hexString:(categories![indexPath.row].color ?? "007AFF") )
//        cell.textLabel?.textColor = ContrastColorOf(<#T##backgroundColor: UIColor##UIColor#>, returnFlat: <#T##Bool#>)
        //cell.backgroundColor  = UIColor.hexValue(UIColor)
        
        //print(cell.backgroundColor!)
        
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
            
           newCategory.color = UIColor.randomFlat.hexValue()
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (field) in
            textField.placeholder = "Add a new category"
            textField = field
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    //MARK: - Delete Dta From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        super.updateModel(at: indexPath)
        
        if let categoryForDeletion = self.categories?[indexPath.row]{
            
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
                
            }catch{
                print("Error deleting category,\(error)")
            }
            
   
            
        }
        
  
        
        
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








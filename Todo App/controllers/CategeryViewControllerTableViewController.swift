//
//  CategeryViewControllerTableViewController.swift
//  Todo App
//
//  Created by Sreenivas k on 06/05/21.
//

import UIKit
import RealmSwift

class CategeryViewControllerTableViewController: UITableViewController {
    var CategoryArray : Results<Categery>?
//    do{
    let realm=try! Realm()
//    }catch{
//    print("Error in intializing")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Categery", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let t = textfield.text{
                print(t)
                let Citem = Categery()
                Citem.name = t
                self.saveData(obj: Citem)
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (field) in
            textfield = field
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategeryCell",for: indexPath)
        cell.textLabel?.text = CategoryArray?[indexPath.row].name ?? "NO items are added"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToItemList", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desVC = segue.destination as! ToDoHomeController
        
        if let indexPath = tableView.indexPathForSelectedRow{
          
            desVC.selectedCategory = CategoryArray?[indexPath.row]
             
        }
        
    }
    
    
    
    func saveData(obj:Categery){
        do{
            try realm.write{
                realm.add(obj)
            }
        }catch{
            print("Error is \(error)")
        }
    }
    
    func getData() {
        
        do{
            CategoryArray = realm.objects(Categery.self)
            tableView.reloadData()

        }catch{
            print("Error is \(error)")
        }
        tableView.reloadData()
    }
}

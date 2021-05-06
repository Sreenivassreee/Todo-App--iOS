//
//  CategeryViewControllerTableViewController.swift
//  Todo App
//
//  Created by Sreenivas k on 06/05/21.
//

import UIKit
import CoreData

class CategeryViewControllerTableViewController: UITableViewController {
var CategoryArray = [Categery]()

    var con = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
                let Citem = Categery(context: self.con)
                Citem.name = t
                self.CategoryArray.append(Citem)
                self.saveData()
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
        return CategoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategeryCell",for: indexPath)
        cell.textLabel?.text = CategoryArray[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToItemList", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desVC = segue.destination as! ToDoHomeController
        
        if let indexPath = tableView.indexPathForSelectedRow{
          
            desVC.selectedCategory = CategoryArray[indexPath.row]
            
        }
        
    }
    
    
    
    func saveData(){
        do{
            try con.save()
        }catch{
            print("Error is \(error)")
        }
    }
    func getData() {
        let request:NSFetchRequest<Categery> = Categery.fetchRequest()
        do{
            CategoryArray = try con.fetch(request)

        }catch{
            print("Error is \(error)")
        }
        tableView.reloadData()
    }
}

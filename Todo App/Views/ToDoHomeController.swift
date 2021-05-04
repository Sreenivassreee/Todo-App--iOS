//
//  ViewController.swift
//  Todo App
//
//  Created by Sreenivas k on 03/05/21.
//

import UIKit

class ToDoHomeController: UITableViewController {
    var ToDoData = ["Hi"]
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = defaults.array(forKey: "ToDoList") as? [String]{
            ToDoData = data
            print(data)
            print(ToDoData)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell",for: indexPath)
        cell.textLabel?.text=ToDoData[indexPath.row]
        return cell
        
    }
    
    @IBAction func AddPressed(_ sender: UIBarButtonItem) {
        var textF=UITextField()
        let alert = UIAlertController(title: "Add New Item to list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text=textF.text{
                
                self.ToDoData.append(text)
                self.defaults.set(self.ToDoData, forKey: "ToDoList")
                self.tableView.reloadData()
              
            }
            
        }
        alert.addTextField { (textField) in
            textField.placeholder="Add New ToDo"
           textF=textField
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
}


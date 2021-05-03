//
//  ViewController.swift
//  Todo App
//
//  Created by Sreenivas k on 03/05/21.
//

import UIKit

class ToDoHomeController: UITableViewController {
var ToDoData=["Sree","Need to Eat","buy laptop"]
    var textItem=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        let alert = UIAlertController(title: "Add New Item to list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Added" + self.textItem)
        }
        alert.addTextField { (textField) in
            textField.placeholder="Add New ToDo"
            self.textItem=String(textField.text ?? "Nil")
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
}


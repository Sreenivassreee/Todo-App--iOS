//
//  ViewController.swift
//  Todo App
//
//  Created by Sreenivas k on 03/05/21.
//

import UIKit

class ToDoHomeController: UITableViewController {
    //    var EachTodo = EachToDo()
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory,in:.userDomainMask).first?.appendingPathComponent("Items.plist")
    var ToDoData = [EachToDo]()
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        var item = EachToDo()
        print(dataFilePath)
        fetchData()
        
        //                if let data = defaults.array(forKey: "ToDoList") as? [String]{
        //                    ToDoData = data
        
        //                }
    }
    
    @IBAction func AddPressed(_ sender: UIBarButtonItem) {
        var textF=UITextField()
        let alert = UIAlertController(title: "Add New Item to list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let t=textF.text{
                var item = EachToDo()
                item.title=t
                self.ToDoData.append(item)
                self.SaveData()
                self.tableView.reloadData()
                
                
                
                //                self.defaults.set(self.ToDoData, forKey: "ToDoList")
                
                
            }
            
        }
        alert.addTextField { (textField) in
            textField.placeholder="Add New ToDo"
            textF=textField
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell",for: indexPath)
        cell.textLabel?.text=ToDoData[indexPath.row].title
        
        let item = ToDoData[indexPath.row]
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath")
            print(indexPath)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //        tableView.deselectRow(at: indexPath, animated: true)
        
        ToDoData[indexPath.row].done = !ToDoData[indexPath.row].done
        SaveData()
        
        
    }
    func SaveData() {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(ToDoData)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error in encloding \(error)")
        }
        tableView.reloadData()
    }
    func fetchData()  {
        do {
            if let data = try? Data(contentsOf:dataFilePath!){
                
                let decoder=PropertyListDecoder()
               
                ToDoData = try decoder.decode([EachToDo].self,from :data)
                tableView.reloadData()
            }
        }catch{
            print("Error in Decoding")
            
        }
    }
}


//
//  ViewController.swift
//  Todo App
//
//  Created by Sreenivas k on 03/05/21.
//

import UIKit
import CoreData

class ToDoHomeController: UITableViewController {
    //    var EachTodo = EachToDo()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dataFilePath = FileManager.default.urls(for: .documentDirectory,in:.userDomainMask)
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
                
                var item = EachToDo(context:self.context)
                
                item.title=t
                item.done=false
                self.ToDoData.append(item)
                self.SaveData()
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
        
//        context.delete(ToDoData[indexPath.row])
//        ToDoData.remove(at: indexPath.row)
        
        
        
        SaveData()
        
        
    }
    func SaveData() {
        //        let encoder = PropertyListEncoder()
        do{
            try context.save()
            //            let data = try encoder.encode(ToDoData)
            //            try data.write(to: dataFilePath!)
        }catch{
            print("Error in encloding \(error)")
        }
        tableView.reloadData()
    }
    func fetchData(with request:NSFetchRequest<EachToDo> = EachToDo.fetchRequest())  {
        do {
//            let request: NSFetchRequest<EachToDo> = EachToDo.fetchRequest()
            ToDoData = try context.fetch(request)
     
            
            
        }catch{
            print("Error in Decoding")
            
        }
        tableView.reloadData()
    }
}

extension ToDoHomeController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text==""{
         fetchData()
        }else{
        let request : NSFetchRequest<EachToDo> = EachToDo.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        fetchData(with : request)
      
        }
        
    }
    
    
    
}

//
//  ViewController.swift
//  Todo App
//
//  Created by Sreenivas k on 03/05/21.
//

import UIKit
import RealmSwift

class ToDoHomeController: UITableViewController {
    //    var EachTodo = EachToDo()
    let realm = try! Realm()

  
    var ToDoItems :Results <EachToDo>?
    
    var selectedCategory:Categery?{
        didSet{
            fetchData()
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     

        
        //                if let data = defaults.array(forKey: "ToDoList") as? [String]{
        //                    ToDoData = data
        
        //                }
    }
    
    @IBAction func AddPressed(_ sender: UIBarButtonItem) {
        var textF=UITextField()
        let alert = UIAlertController(title: "Add New Item to list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let t=textF.text{
                
                if let curentCateregy = self.selectedCategory{
                    
                    do{
                        try self.realm.write(){
                            var item = EachToDo()
                            item.title=t
                            curentCateregy.items.append(item)
                        }
                    }catch{
                        print("Error in encloding \(error)")
                    }
                    
                    
                }
                
             
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
        return ToDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell",for: indexPath)
        cell.textLabel?.text=ToDoItems?[indexPath.row].title ?? "NO Items Added"
        
      if let item = ToDoItems?[indexPath.row] {
            cell.accessoryType = item.done ? .checkmark : .none
      }else{
        cell.textLabel?.text="No Items are there"
      }
        
     
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath")
        print(indexPath)
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if let item=ToDoItems?[indexPath.row]{
            do{
                try realm.write(){
                item.done = !item.done
            }
            }catch{
                print("Eroor")
            }
        }
        tableView.reloadData()
        //        tableView.deselectRow(at: indexPath, animated: true)
        
//        ToDoData[indexPath.row].done = ToDoData?[indexPath.row].done

//        SaveData()
        
        
    }
    func SaveData(item:EachToDo) {
       
        tableView.reloadData()
    }
    func fetchData()  {
        
        ToDoItems=selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

extension ToDoHomeController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text==""{
         fetchData()
        }else{
            ToDoItems = self.ToDoItems?.filter("title CONTAINS[cd] %@",searchBar.text)
            tableView.reloadData()
        

        }

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count==0{
            fetchData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }



}


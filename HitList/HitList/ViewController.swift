//
//  ViewController.swift
//  HitList
//
//  Created by Cecilia Zhang on 6/23/19.
//  Copyright © 2019 Cecilia Zhang. All rights reserved.
//

import UIKit
import CoreData
@_exported import DBService
//你看看这里，Swift怎样导入这种旁边的class

class ViewController: UIViewController {
    
    var people: [NSManagedObject] = []
    let dbService = DBService()
    
    @IBOutlet var tableView: UITableView!
    var names: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }

    override func viewWillAppear(_ animated: Bool){
        
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
            
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest <NSManagedObject>(entityName: "Person")
        // search criteria used to retrieve data from a persistent store.
        do{
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError{
            print("Could not fetch.\(error), \(error.userInfo)")
        }
    }
    
    @IBAction func addName(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        
        
        //定义弹窗中的“Save”键
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            //保证输入的text符合name的要求，然后存储
            [unowned self] action in guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            DBService.save(name: nameToSave)
            //使tabelView重新载入数据
            self.tableView.reloadData()
        }
        //定义弹窗中的“Cancel”键
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        //把设定好的TextFeild、Save、和Cancel放入窗口视图中
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }

}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        return cell
    }
}

//
//  ToDoViewController.swift
//  FamilyFirst
//
//  Created by Niklas Wagner on 24.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
 
    @IBOutlet weak var toDoTableView: UITableView!
    
        
        var tasks: [Task] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            toDoTableView.delegate = self
            toDoTableView.dataSource = self
            toDoTableView.tableFooterView = UIView()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            let tasks = try! UIApplication.appDelegate.persistentContainer.viewContext.fetch(NSFetchRequest(entityName: "Task")) as! [Task]
            self.tasks = tasks
            toDoTableView.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tasks.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
            
            
            cell.taskNameLabel?.text = tasks[indexPath.row].task
            
            // If task was pressed => completed = true
            if UserDefaults.standard.bool(forKey: tasks[indexPath.row].task!) == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Mark task as completed:
            if UserDefaults.standard.bool(forKey: tasks[indexPath.row].task!) == true {
                UserDefaults.standard.set(false, forKey: tasks[indexPath.row].task!)
            } else {
                UserDefaults.standard.set(true, forKey: tasks[indexPath.row].task!)
            }
            toDoTableView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
        
        // Remove task:
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                UIApplication.appDelegate.persistentContainer.viewContext.delete(tasks[indexPath.row])
                try! UIApplication.appDelegate.persistentContainer.viewContext.save()
                tasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }
        }
    }

    
    


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
            toDoTableView.backgroundColor = UIColor.clear
           self.view.backgroundColor = UIColor(patternImage: UIImage(named:"multi")!)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            let tasks = try! UIApplication.appDelegate.persistentContainer.viewContext.fetch(NSFetchRequest(entityName: "Task")) as! [Task]
            self.tasks = tasks
            toDoTableView.reloadData()
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
            
            
            cell.taskNameLabel?.text = tasks[indexPath.section].task
            
            // If task was pressed => completed = true
            if UserDefaults.standard.bool(forKey: tasks[indexPath.section].task!) == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            cell.layer.cornerRadius = 15.0
            cell.layer.backgroundColor = UIColor(displayP3Red: 194, green: 201, blue: 204, alpha: 0.3).cgColor
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Mark task as completed:
            if UserDefaults.standard.bool(forKey: tasks[indexPath.section].task!
) == true {
                UserDefaults.standard.set(false, forKey: tasks[indexPath.section].task!)
            } else {
                UserDefaults.standard.set(true, forKey: tasks[indexPath.section].task!)
            }
            toDoTableView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
        
        // Remove task:
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                UIApplication.appDelegate.persistentContainer.viewContext.delete(tasks[indexPath.section])
                try! UIApplication.appDelegate.persistentContainer.viewContext.save()
                tasks.remove(at: indexPath.section)
                toDoTableView.reloadData()
               
            }
        }
    }

    
    


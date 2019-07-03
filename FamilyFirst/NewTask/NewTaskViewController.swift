//
//  NewTaskViewController.swift
//  FamilyFirst
//
//  Created by Niklas Wagner on 24.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit
import CoreData

class NewTaskViewController: UIViewController {
    
    var task: Task?
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var newTaskField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"multi")!)
       
        if let task = task {
            taskLabel.text = task.task
            newTaskField.placeholder = task.task?.isEmpty == true ? "Enter new task" : "Change task"
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        if newTaskField.text != "" {
            taskLabel.text = newTaskField.text
            task?.task = newTaskField.text ?? ""
            task?.completed = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let newItem = Task(context: context)
            newItem.task = newTaskField.text
            
            newItem.completed = false
            
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
       
        dismiss(animated: true)
    }
    
}


//
//  SettingsTableViewController.swift
//  FamilyFirst
//
//  Created by Niklas Wagner on 19.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var changeNameButton: UIButton!
    @IBOutlet weak var newNameTextField: UITextField!
    
    @IBOutlet var changeNamePopOver: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func editNameButtonPressed(_ sender: UIButton) {
        
       self.view.addSubview(changeNamePopOver)
        changeNamePopOver.center = self.view.center
        
    }
    @IBAction func saveNewName(_ sender: UIButton) {
        
        if !newNameTextField.text!.isEmpty {
            
             UserDefaults.standard.set(newNameTextField.text, forKey: "familyName")
        }
        
        self.changeNamePopOver.removeFromSuperview()
    }
    
    
    
    
    
}

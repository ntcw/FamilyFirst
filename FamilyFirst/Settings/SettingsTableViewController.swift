//
//  SettingsTableViewController.swift
//  FamilyFirst
//
//  Created by Niklas Wagner on 19.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit


// 375
// 230

class SettingsTableViewController: UITableViewController {
    
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var changeNameButton: UIButton!
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet var changeNamePopOver: UIView!
    @IBOutlet var settingsTableView: UITableView!
    @IBOutlet weak var clearData: UIButton!
    @IBOutlet var clearDataPopOver: UIView!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet var aboutPopOver: UIView!
    
    @IBOutlet weak var cancelClearData: UIButton!
    @IBOutlet weak var confirmClearData: UIButton!
    let blackView = UIView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          settingsTableView.tableFooterView = UIView()
        aboutLabel.numberOfLines = 2;
        aboutLabel.text = "FamilyFirst: Version 1.0 by Benedikt Langer and Niklas Wagner"
        
        
    }
    
    
    // Edit family name:
    
    @IBAction func editNameButtonPressed(_ sender: UIButton) {
        

        if let window = UIApplication.shared.keyWindow {
            
            getBlackBackground()
        
            window.addSubview(changeNamePopOver)
            changeNamePopOver.center = self.view.center
            self.changeNamePopOver.backgroundColor = UIColor.white
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
        }, completion: nil)
            
        }
        
    }
    
    @IBAction func saveNewName(_ sender: UIButton) {
        
        if !newNameTextField.text!.isEmpty {
            
            UserDefaults.standard.set(newNameTextField.text, forKey: "familyName")
        }
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
        }
        self.changeNamePopOver.removeFromSuperview()
    }
    
    
    // Clear family data:
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        if let window = UIApplication.shared.keyWindow {
            
            getBlackBackground()
            window.addSubview(clearDataPopOver)
            clearDataPopOver.center = self.view.center
            self.clearDataPopOver.backgroundColor = UIColor.white
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
            }, completion: nil)
            
        }
        
        
    }
    
    @IBAction func confirmClearButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
        }
        self.clearDataPopOver.removeFromSuperview()
        
        
    }
    
    @IBAction func cancelClearButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
        }
        self.clearDataPopOver.removeFromSuperview()
        
    }
    
    
    // About us:
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        
        
        if let window = UIApplication.shared.keyWindow {
            
            getBlackBackground()
            
            window.addSubview(aboutPopOver)
            aboutPopOver.center = self.view.center
            self.aboutPopOver.backgroundColor = UIColor.white
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
            }, completion: nil)
            
        }
        
        
    }
    
    
    // exist pop over view by touching outside of the pop over view:
    @objc func handleDismiss() {
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
           
        }
        self.changeNamePopOver.removeFromSuperview()
        self.clearDataPopOver.removeFromSuperview()
          self.aboutPopOver.removeFromSuperview()
    }
    
   
    
    
    
    // Dim the background while in pop over view
    func getBlackBackground() {
        
        if let window = UIApplication.shared.keyWindow {
        blackView.backgroundColor = UIColor.init(white: 0, alpha:   0.5)
        blackView.frame = window.frame
        blackView.alpha = 0
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        window.addSubview(blackView)
        }
    }
    
    
    
}

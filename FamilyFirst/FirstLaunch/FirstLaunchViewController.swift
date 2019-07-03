//
//  FirstLaunchViewController.swift
//  FamilyFirst
//
//  Created by Niklas Wagner on 19.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

class FirstLaunchViewController: UIViewController {
    
    @IBOutlet weak var familyName: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupKeyboardDismiss()
      
        }
    
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        
        if !(familyName.text?.isEmpty)! {
    
        UserDefaults.standard.set(familyName.text, forKey: "familyName")
            
        }
        else {
             UserDefaults.standard.set("Meine Familie", forKey: "familyName")
        }
        
        
    }
    
    func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    
    
    
    
    
}

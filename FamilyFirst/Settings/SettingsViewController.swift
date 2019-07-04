//
//  SettingsViewController.swift
//  FamilyFirst
//
//  Created by Niklas Wagner on 19.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    
    
    @IBOutlet var settingsViewController: UIView!
    @IBOutlet weak var settingsView: UIView!
    
    override func viewDidLoad() {
     //   self.view.backgroundColor = UIColor(patternImage: UIImage(named:"multi")!)
        settingsView.center = settingsViewController.center
    }
    
    
}

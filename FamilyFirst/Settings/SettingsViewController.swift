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
    @IBOutlet var settingsView: UIView!

    override func viewDidLoad() {
        settingsView.center = settingsViewController.center
    }
}

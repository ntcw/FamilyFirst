//
//  SettingsTableViewController.swift
//  FamilyFirst
//
//  Created by Niklas Wagner on 19.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit
import CoreData


class SettingsTableViewController: UITableViewController {
    
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var changeNameButton: UIButton!
    @IBOutlet var newNameTextField: UITextField!
    @IBOutlet var changeNamePopOver: UIView!
    @IBOutlet var settingsTableView: UITableView!
    @IBOutlet var clearData: UIButton!
    @IBOutlet var clearDataPopOver: UIView!
    @IBOutlet var aboutButton: UIButton!
    @IBOutlet var aboutPopOver: UIView!
    @IBOutlet weak var clearText1: UILabel!
    @IBOutlet weak var clearText2: UILabel!
    @IBOutlet weak var aboutText: UILabel!
    
    @IBOutlet var cancelClearData: UIButton!
    @IBOutlet var confirmClearData: UIButton!
    let blackView = UIView()
    let greyBackground = UIColor(displayP3Red: 203.0, green: 207.0, blue: 212.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.tableFooterView = UIView()
        aboutLabel.numberOfLines = 2
        aboutLabel.text = "FamilyFirst: Version 1.0 by \nBenedikt Langer and Niklas Wagner"
       

        settingsTableView.layer.cornerRadius = 15
        changeNamePopOver.layer.cornerRadius = 45
        clearDataPopOver.backgroundColor = greyBackground
        aboutPopOver.backgroundColor = greyBackground
        clearDataPopOver.layer.cornerRadius = 45
        aboutPopOver.layer.cornerRadius = 45
        clearText1.font = UIFont(name: "KohinoorTelugu-Medium", size: 17)
        clearText2.font = UIFont(name: "KohinoorTelugu-Medium", size: 17)
        aboutText.font = UIFont(name: "KohinoorTelugu-Medium", size: 18)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(displayP3Red: 194.0, green: 201.0, blue: 204.0, alpha: 0.3)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    

    // Edit family name:

    @IBAction func editNameButtonPressed(_ sender: UIButton) {
        if let window = UIApplication.shared.keyWindow {
            getBlackBackground()

            window.addSubview(changeNamePopOver)
            changeNamePopOver.center = window.center
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
        changeNamePopOver.removeFromSuperview()
    }

    // Clear family data:

    @IBAction func clearButtonPressed(_ sender: UIButton) {
        if let window = UIApplication.shared.keyWindow {
            getBlackBackground()
            window.addSubview(clearDataPopOver)
            clearDataPopOver.center = window.center
           

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
            }, completion: nil)
        }
    }

    @IBAction func confirmClearButtonPressed(_ sender: UIButton) {
      
        deleteAllData(entity: "FamilyMember")
        deleteAllData(entity: "Task")
        UserDefaults.standard.set("Meine Familie", forKey: "familyName")

        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
        clearDataPopOver.removeFromSuperview()
    }

    func deleteAllData(entity: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }


    @IBAction func cancelClearButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
        clearDataPopOver.removeFromSuperview()
    }

    // About us:

    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        if let window = UIApplication.shared.keyWindow {
            getBlackBackground()

            window.addSubview(aboutPopOver)
            aboutPopOver.center = window.center
          
            
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
        changeNamePopOver.removeFromSuperview()
        clearDataPopOver.removeFromSuperview()
        aboutPopOver.removeFromSuperview()
    }

    // Dim the background while in pop over view
    func getBlackBackground() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
        }
    }
}

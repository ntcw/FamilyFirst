//
//  AddMemberSubviewController.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 20.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

class AddMemberSubviewController: UITableViewController{
    
    var datePickerHidden = true
    
    @IBOutlet weak var dateLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0{
            return 175
        }
        else if datePickerHidden && indexPath.section == 0 && indexPath.row == 2{
            return 0
        }else if !datePickerHidden && indexPath.section == 0 && indexPath.row == 2{
            return 190
        }
        else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            setDate(pickerHidden: false)
        }else if indexPath.section == 0 && indexPath.row == 1 && !datePickerHidden{
            setDate(pickerHidden: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            datePickerHidden = true
            tableView.reloadData()
        }
    }
    
    func setDate(pickerHidden: Bool){
        datePickerHidden = pickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy"
        dateLabel.text = dateFormatter.string(from: sender.date)
    }
    
}

extension AddMemberSubviewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
}

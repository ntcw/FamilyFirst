//
//  AddMemberViewController.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 20.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController {
    
    var member: FamilyMember?

    var name: String?
    var date: Date?
    var image: UIImage?
    var subview: AddMemberSubviewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let subviewController = children.first as? AddMemberSubviewController else {
            fatalError("Check Storyboard for missing controller")
        }
        subview = subviewController
        subview?.delegate = self

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        MemberClass.allMembers.save(name: name ?? "nA", date: date ?? Date(), image: image)
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}

extension AddMemberViewController: AddMemberSubviewControllerDelegate{
    
    func getName(name: String?) {
        self.name = name
    }
    
    func getBirthdate(date: Date?) {
        self.date = date
    }
    
    func getImage(image: UIImage?) {
        self.image = image
    }
}

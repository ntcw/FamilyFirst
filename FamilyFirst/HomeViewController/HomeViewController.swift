//
//  HomeViewController.swift
//  FamilyFirst
//
//  Created by Niklas Wagner on 19.05.19.
//  Copyright © 2019 Niklas. All rights reserved.
//


import CoreData
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var members = MemberClass.allMembers
    var selectedMember: FamilyMember?
    var memberArray: [FamilyMember] = [FamilyMember]()
    let defaults = UserDefaults.standard
    let standardPicture = UIImage(named: "smile")!
    var colorArray = [UIColor]()
    let orange = UIColor.orange
    let red = UIColor.red
    let yellow = UIColor.yellow
    let blue = UIColor.blue
    var counter = 0
    let colorRedHex = "#F2522E"
    let colorBlueHex = "#36A6BF"
    
    @IBOutlet weak var familyLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        members.loadMember()
        defaults.synchronize()
        familyLabel.font = UIFont(name:"Futura",size: 35)
        let familyname = defaults.object(forKey: "familyName") as! String
        familyLabel.text = familyname
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"multi")!)
        tableView.backgroundColor = UIColor.clear
        colorArray.append(orange)
        colorArray.append(red)
        colorArray.append(yellow)
        colorArray.append(blue)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell", for: indexPath) as! MemberCellTableViewCell
        
        let member = members.getMember(at: indexPath.row)
        cell.Name.text = member?.name ?? ""
        if let image = member?.picture{
           
            cell.memberPicture.image =  UIImage(data: image)
            cell.memberPicture.setRounded()
            cell.memberPicture.layer.borderWidth = 1
            cell.memberPicture.layer.masksToBounds = false
           cell.memberPicture.layer.borderColor = UIColor.black.cgColor
            cell.memberPicture.layer.cornerRadius = cell.memberPicture.frame.height/2
            cell.memberPicture.clipsToBounds = true
           
            
        }
        else {
            cell.imageView?.image = standardPicture
        }
        
        if counter == colorArray.count {
            counter = 0
        }
       
//        cell.layer.backgroundColor = UIColor(hexString: colorBlueHex).cgColor
//       cell.layer.backgroundColor = colorArray[counter].cgColor
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.accessoryType = .disclosureIndicator
        counter += 1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        button.backgroundColor = UIColor(red: 205/255, green: 207/255, blue: 211/255, alpha: 0.5)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        button.setTitle("Add member", for: .normal)
     
        button.setTitleColor(UIColor.black, for: .normal)
        footer.addSubview(button)

        return footer
    }
    
    @objc func buttonPressed(_ Button: UIButton){
        performSegue(withIdentifier: "toAddMember", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memberArray = members.getMembers()
            
            let memberToDelete = members.getMember(at: indexPath.row)
            
            if let memberRemove = memberToDelete {
                members.deleteMember(member: memberRemove)
                memberArray.remove(at: indexPath.row)
          
                
            }
            members.loadMember()
            tableView.reloadData()
        }
    }
    
    
    
}



extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}

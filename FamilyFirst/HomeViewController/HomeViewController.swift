//
//  HomeViewController.swift
//  FamilyFirst
//
//  Created by Niklas Wagner on 19.05.19.
//  Copyright © 2019 Niklas. All rights reserved.
//



import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var members = MemberClass.allMembers
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var familyLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        defaults.synchronize()
        let familyname = defaults.object(forKey: "familyName") as! String
        familyLabel.text = familyname
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"multi")!)
        tableView.backgroundColor = UIColor.clear
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell", for: indexPath) as! MemberCellTableViewCell
        let member = members.getMember(at: indexPath.row)
        cell.Name.text = member?.name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        button.backgroundColor = UIColor(red: 205/255, green: 207/255, blue: 211/255, alpha: 0.5)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        button.setTitle("Add new member", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        footer.addSubview(button)

        return footer
    }
    
    @objc func buttonPressed(_ Button: UIButton){
        performSegue(withIdentifier: "toAddMember", sender: self)
        
    }
    
    
    
}


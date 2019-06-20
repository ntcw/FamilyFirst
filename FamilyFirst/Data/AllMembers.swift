//
//  AllMembers.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 19.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import CoreData
import UIKit

class MemberClass {
    
    static let allMembers = MemberClass()
    
    private var members: [FamilyMember] = [FamilyMember]()
    
    let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func getMembers() ->[FamilyMember]{
        return members
    }
    
    func count() -> Int{
        return members.count
    }
    
    func getMember(at index: Int) ->FamilyMember?{
        if index < members.count && index >= 0{
            return members[index]
        }
        return nil
    }
    
    
    
}

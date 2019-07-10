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
    
    let context: NSManagedObjectContext
    
    private init() {
        
        context = delegate.persistentContainer.viewContext
        
    }
    
    
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
    
    
    func save(name: String, date: Date, image: UIImage? = nil, healthCare: Int32, bloodtype: String?, allergy: String?, vaccination: String?, phoneNr: Int32, email: String?, street: String?, postalCode: Int16, city: String?, addTitle: [String]?, addDetail: [String]?){
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "FamilyMember")
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        

        
        
        
        do {
            let fetchResults = try context.fetch(request) as! [FamilyMember]
            let member: FamilyMember
            if !fetchResults.isEmpty {
                member = fetchResults[0]
            }else {
                member = FamilyMember(context: context)
            }
            member.birthday = date
            member.name = name
            member.picture = image?.pngData()
            member.healthCare = healthCare
            member.bloodtype = bloodtype
            member.allergies = allergy
            member.vaccinations = vaccination
            member.phoneNr = phoneNr
            member.email = email
            member.street = street
            member.zipcode = postalCode
            member.city = city
            member.additionalTitle = addTitle
            member.additional = addDetail
            
            
            try context.save()
            loadMember()
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func loadMember() {
        
        let entity = NSFetchRequest<NSManagedObject>(entityName: "FamilyMember")
        
        do {
            members = try context.fetch(entity) as! [FamilyMember]
        }
        catch let error as NSError {
            
            print(error.localizedDescription)
        }
    }
    
    func deleteMember(member: FamilyMember) {
        
        do {
            
            context.delete(member)
           
            try context.save()
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
            
        }
        
    }
    
    
    
    
    
}

//
//  Additional.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 04.07.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import CoreData
import UIKit

class AdditionalClass {
    
    static let allAdditional = AdditionalClass()
    
    private var additionals: [Additional] = [Additional]()
    
    let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let context: NSManagedObjectContext
    
    private init() {
        context = delegate.persistentContainer.viewContext
    }
    
    func getAditional() ->[Additional]{
        return additionals
    }
    
    func count() ->Int{
        return additionals.count
    }
    
    func getAdditional(at index: Int) -> Additional?{
        if index < additionals.count && index >= 0{
            return additionals[index]
        }
        return nil
    }
    
    func save(stuff: [String] ){
        let additional = Additional(context: context)
        additional.addStuff = stuff as NSArray
        do {
            try context.save()
            loadAdditional()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func loadAdditional() {
        
        let entity = NSFetchRequest<NSManagedObject>(entityName: "Additional")
        
        do {
            additionals = try context.fetch(entity) as! [Additional]
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteAdditional(additional: Additional) {
        
        do {
            
            context.delete(additional)
            
            try context.save()
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
            
        }
        
    }
    
}

//
//  CardDatabase.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit
import CoreData

class CardDatabase: NSObject {
    private static let managedContext = DatabaseInstance.SharedInstance().managedObjectContext()
    private static let persistentCoordinator = DatabaseInstance.SharedInstance().persistentStoreCoordinator
    private static let entityName = "CardEntity"
    
    public class func getAllObjects() -> [CardModel] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let fetchResults = try? managedContext.fetch(fetchRequest)
        guard let objects = fetchResults as? [CardManagedObject] else { return [] }
        return objects.map({ return $0.object })
    }
    
    public class func saveNewObject(object: IdentityModel, image: UIImage, faceImage: UIImage) -> Bool {
        guard let newObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: managedContext) as? CardManagedObject else { return false }
        newObject.id = getNewID()
        
        newObject.idNumber = object.idNumber
        newObject.firstName = object.firstName
        newObject.sureName = object.sureName
        newObject.sureNameBirthDate = object.sureNameBirthDate
        newObject.gender = object.gender?.rawValue
        newObject.birthdate = object.birthdate
        newObject.signature = object.signature
        newObject.nationality = object.nationality
        newObject.faceImage = faceImage.pngData()
        
        newObject.image = image.pngData()
        newObject.date = getDate()
        
        do {
            try managedContext.save()
            return true
        }
        catch {
            return false
        }
    }
    
    public class func deleteObject(id: NSNumber) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let fetchResults = try? managedContext.fetch(fetchRequest)
        guard let objects = fetchResults as? [CardManagedObject] else { return false }
        
        var deletedObject: CardManagedObject = CardManagedObject()
        for object in objects {
            if object.id == id {
                deletedObject = object
            }
        }
        
        managedContext.delete(deletedObject)
        
        do {
            try managedContext.save()
            return true
        }
        catch {
            return false
        }
    }
    
    private class func getNewID() -> NSNumber {
        let lastID = getAllObjects().count + 1
        return NSNumber(value: lastID)
    }
    
    private class func getDate() -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "GMT")
        formatter.dateFormat = "d MMM, yyyy"
        
        let dateStr = formatter.string(from: Date())
        return formatter.date(from: dateStr) ?? Date()
    }
}

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

    public class func getObject(id: NSNumber) -> CardManagedObject? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        let fetchResults = try? managedContext.fetch(fetchRequest)
        guard let objects = fetchResults as? [CardManagedObject] else { return nil }
        return objects.first
    }
    
    public class func getAllObjects() -> [CardManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let fetchResults = try? managedContext.fetch(fetchRequest)

        guard let objects = fetchResults as? [CardManagedObject] else { return [] }
        return objects
    }
    
    public class func saveNewObject(identity: IdentityModel, image: UIImage, faceImage: UIImage) -> Bool {
        guard let newObject = getNewObject() else { return false }
        newObject.id = getNewID()
        newObject.updateObject(identity: identity, image: image, date: Utilities.getCurrentDate())
        newObject.cardImage = image.pngData()
        
        return saveContext()
    }
    
    public class func deleteObject(id: NSNumber) -> Bool {
        guard let deletedObject = getObject(id: id) else { return false }
        managedContext.delete(deletedObject)

        return saveContext()
    }
    
    private class func saveContext() -> Bool {
        do {
            try managedContext.save()
            return true
        }
        catch {
            return false
        }
    }
    
    private class func getNewObject() -> CardManagedObject? {
        return NSEntityDescription.insertNewObject(
            forEntityName: entityName,
            into: managedContext) as? CardManagedObject
    }
    
    private class func getNewID() -> NSNumber {
        let lastID = getAllObjects().count + 1
        return NSNumber(value: lastID)
    }
}

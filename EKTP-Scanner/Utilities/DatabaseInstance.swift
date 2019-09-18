//
//  DatabaseInstance.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit
import CoreData

class DatabaseInstance: NSObject {
    private static var sharedInstance = DatabaseInstance()
    private override init() {
        super.init()
    }
    class func SharedInstance() -> DatabaseInstance {
        return sharedInstance
    }
    
    func managedObjectContext() -> NSManagedObjectContext {
        return managedObjectContextLazy
    }
    lazy var managedObjectContextLazy: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "EKTP_Scanner", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("EKTP_Scanner.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            let alertController = UIAlertController(title: "Error", message: "Failed to load database", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(
            title: "OK", style: .default) { (action) in
                exit(0)
            }
            
            alertController.addAction(confirmAction)
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.present(alertController, animated: true,  completion: nil)
            
        }
        
        return coordinator
    }()
    
}

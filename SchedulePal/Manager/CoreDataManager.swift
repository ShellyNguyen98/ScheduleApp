//
//  CoreDataManager.swift
//  SchedulePal
//
//  Created by Shawn Shirazi on 2/6/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistenceContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        
        persistenceContainer = NSPersistentContainer(name: "SchedulePal")
        persistenceContainer.loadPersistentStores { NSEntityDescription, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
}

//
//   CoreDataManager.swift
//  Feel Better App
//
//  Created by Sadia Khan on 11/19/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Feel_Better_App")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data: \(error.localizedDescription)")
            }
        }
    }
}

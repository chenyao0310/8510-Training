//
//  ChatCoreDataManager.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/21.
//

import Foundation
import CoreData

class ChatCoreDataManager {
    
    var context: NSManagedObjectContext {
       return persistentContainer.viewContext
   }
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ChatCoreData")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
            if context.hasChanges {
            do{
                try context.save()
                print("Save success")
            } catch {
               print("CoreData Save Failed")
               print("Error: \(error)")
            }
        }
    }
    
    func fetchChatHistory() -> [History] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        do {
            print("Fetch Chat History Success")
            return try context.fetch(fetchRequest)
        } catch {
            print("Get Chat History Failed")
            print("Error: \(error)")
        }
        return []
    }
    
    func deleteAllChatHistory() {
        let context = persistentContainer.viewContext
       
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(deleteRequest)
            print("CoreData Delete All Chat History Success")
        } catch {
            print("DeleteAllChatHistory Error: \(error)")
        }
    }
}

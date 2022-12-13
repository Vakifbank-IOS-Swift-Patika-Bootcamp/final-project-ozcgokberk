//
//  CoreDataManager.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//


import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveGameNote(id: String, gameId: Int, gameNote: String, gameImage: String) -> Notes? {
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext)!
        let notes = NSManagedObject(entity: entity, insertInto: managedContext)
        notes.setValue(id, forKey: "id")
        notes.setValue(gameId, forKey: "gameId")
        notes.setValue(gameNote, forKey: "gameNote")
        notes.setValue(gameImage, forKey: "gameImage")
        if save() {
            return notes as? Notes
        }
        return nil
    }
    
    func deleteNotes(_ objectID: NSManagedObjectID) {
        let obj = managedContext.object(with: objectID)
        managedContext.delete(obj)
    }
    
    func deleteAllNotes() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Notes")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.persistentStoreCoordinator?.execute(deleteRequest, with: managedContext)
        } catch {
          print( "Error on deletion of entity:" + error.localizedDescription)
            
        }
      }
    
    func getNoteById(gameId: Int) -> Notes? {
        return getNotes().filter { note in
            note.gameId == Int32(gameId)
        }.first
    }
    
    func getNotes() -> [Notes] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Notes]
        } catch  let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return []
    }
    
    func notUpdate(id: String, gameId: Int32) {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.predicate = NSPredicate(format: "gameId = %@", argumentArray: [id])
        
        do {
            let results = try managedContext.fetch(request)
            if results.count != 0 {
                let notes = results[0]
                
                notes.setValue(id, forKey: "id")
                notes.setValue(gameId, forKey: "gameId")
                self.save()
            }
        } catch {
            print("Fetch Failed: \(error)")
        }
    }
    
    func getFavorites() -> [Favorites] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        do {
            let favorites = try managedContext.fetch(fetchRequest)
            return favorites as! [Favorites]
        } catch  let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return []
    }
    
    func saveFavorites(id: String,  gameId: Int32, gameImg: String) -> Favorites? {
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: managedContext)!
        let favorites = NSManagedObject(entity: entity, insertInto: managedContext)
        favorites.setValue(id, forKey: "id")
        favorites.setValue(gameId, forKey: "gameId")
        favorites.setValue(gameImg, forKey: "gameImg")
                if save() {
            return favorites as? Favorites
        }
        return nil
    }
    
    func ifFavoritesExist(gameId: Int32) -> Bool {
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        request.predicate = NSPredicate(format: "gameId = %@", argumentArray: [gameId])
        do {
            let results = try managedContext.fetch(request)
            return results.count > 0
        } catch {
            print("Fetch Failed: \(error)")
            return false
        }
    }

    
    @discardableResult
    func save() -> Bool {
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error.localizedDescription), \(error.userInfo)")
        }
        return false
    }
    
    func ifNotesExist(id: String) -> Bool {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        do {
            let results = try managedContext.fetch(request)
            return results.count > 0
        } catch {
            print("Fetch Failed: \(error)")
            return false
        }
    }
    
    
    
}


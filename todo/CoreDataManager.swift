//
//  CoreDataManager.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 5.10.2021.
//

import Foundation
import CoreData
import UIKit

struct CoreDataManager {
    
    var toDos: [ToDo] = []
    
    mutating func getAllItems() -> [ToDo] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoItem")
        do {
            let fetchResults = try context.fetch(fetchRequest)
            for item in fetchResults as! [NSManagedObject] {
                let id = item.value(forKey: "id") as! Int
                let title = item.value(forKey: "title") as! String
                let startDate = item.value(forKey: "startDate") as! Date
                let endDate = item.value(forKey: "endDate") as? Date
                let completed = item.value(forKey: "completed") as! Bool
                let toDo = ToDo(id: id, title: title, startDate: startDate, endDate: endDate, completed: completed)
                toDos.append(toDo)
            }
        } catch {
            print("Fetch Error")
        }
        return toDos
    }
    
    mutating func createItem(id: Int, title: String, endDate: Date?, completed: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "ToDoItem", in: context) else { return }
        
        let newItem = NSManagedObject(entity: entity, insertInto: context)
        newItem.setValue(id, forKey: "id")
        newItem.setValue(title, forKey: "title")
        newItem.setValue(Date(), forKey: "startDate")
        newItem.setValue(endDate, forKey: "endDate")
        newItem.setValue(completed, forKey: "completed")
        do {
            try context.save()
        } catch  {
            print("create catch")
        }
    }
    
    func updateItemComplete(todoId id: Int) {
        var toDo: ToDoItem
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchToDo: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        fetchToDo.predicate = NSPredicate(format: "id == %d", id as Int)
        
        let results = try? context.fetch(fetchToDo)
        
        if results?.count == 0 {
            toDo = ToDoItem(context: context)
        } else {
            toDo = (results?.first)!
        }
        toDo.completed.toggle()
        do {
            try context.save()
        } catch  {
            print("update item complete catch")
        }
    }
    
    //    func updateItem(item: ToDoItem, title: String, endDate: Date? = nil) {
    //        item.title = title
    //        item.endDate = endDate
    //        do {
    //            try context.save()
    //        } catch  {
    //
    //        }
    //    }
    
}

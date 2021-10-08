//
//  CoreDataManager.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 5.10.2021.
//

import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    mutating func getAllItems() -> [ToDo]
    mutating func createItem(id: Int, title: String, endDate: Date?)
    func updateItemComplete(todoId id: Int)
}

struct CoreDataManager: CoreDataManagerProtocol {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    mutating func getAllItems() -> [ToDo] {
        var toDos: [ToDo] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ToDoItemEnum.entityName.rawValue)
        do {
            let fetchResults = try context.fetch(fetchRequest)
            for item in fetchResults as! [NSManagedObject] {
                let id = item.value(forKey: ToDoItemEnum.id.rawValue) as! Int
                let title = item.value(forKey: ToDoItemEnum.title.rawValue) as! String
                let startDate = item.value(forKey: ToDoItemEnum.startDate.rawValue) as! Date
                let endDate = item.value(forKey: ToDoItemEnum.endDate.rawValue) as? Date
                let completed = item.value(forKey: ToDoItemEnum.completed.rawValue) as! Bool
                let toDo = ToDo(id: id, title: title, startDate: startDate, endDate: endDate, completed: completed, color: .systemIndigo)
                toDos.append(toDo)
            }
        } catch let nserror as NSError {
            print("ERROR: Coredata error \(nserror)")
        }
        return toDos
    }
    
    mutating func createItem(id: Int, title: String, endDate: Date?) {
        guard let entity = NSEntityDescription.entity(forEntityName: ToDoItemEnum.entityName.rawValue, in: context)
        else { return }
        let newItem = NSManagedObject(entity: entity, insertInto: context)
        newItem.setValue(id, forKey: ToDoItemEnum.id.rawValue)
        newItem.setValue(title, forKey: ToDoItemEnum.title.rawValue)
        newItem.setValue(Date(), forKey: ToDoItemEnum.startDate.rawValue)
        newItem.setValue(endDate, forKey: ToDoItemEnum.endDate.rawValue)
        newItem.setValue(false, forKey: ToDoItemEnum.completed.rawValue)
        contextSave()
    }
    
    func updateItemComplete(todoId id: Int) {
        var toDo: ToDoItem
        let fetchToDo: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        fetchToDo.predicate = NSPredicate(format: "\(ToDoItemEnum.id.rawValue) == %d", id as Int)
        let results = try? context.fetch(fetchToDo)
        if results?.count == 0 {
            toDo = ToDoItem(context: context)
        } else {
            toDo = (results?.first)!
        }
        toDo.completed.toggle()
        contextSave()
    }
    
    private func contextSave(){
        do {
            try context.save()
        } catch let nserror as NSError {
            print("ERROR: Coredata error \(nserror)")
        }
    }
}

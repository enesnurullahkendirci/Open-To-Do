//
//  CoreDataManager.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 5.10.2021.
//

import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func getAllItems() -> [ToDo]
    func createItem(title: String, detail: String, endDate: Date?, color: UIColor)
    func updateItemComplete(todoId id: Int)
    func updateItem(todoId id: Int, title: String, detail: String, endDate: Date?, color: UIColor)
    
    func getItemFromId(todoId id: Int) -> ToDo
}

class CoreDataManager: CoreDataManagerProtocol {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var numberOfToDos = 0
    
    func getAllItems() -> [ToDo] {
        var toDos: [ToDo] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ToDoItemEnum.entityName.rawValue)
        do {
            let fetchResults = try context.fetch(fetchRequest)
            for item in fetchResults as! [NSManagedObject] {
                let toDo = createToDoFromNSManagedObject(managedObject: item)
                toDos.append(toDo)
            }
        } catch let nserror as NSError {
            print("ERROR: Coredata error \(nserror)")
        }
        numberOfToDos = toDos.count
        return toDos
    }
    
    func createItem(title: String, detail: String, endDate: Date?, color: UIColor) {
        guard let entity = NSEntityDescription.entity(forEntityName: ToDoItemEnum.entityName.rawValue, in: context)
        else { return }
        let newItem = NSManagedObject(entity: entity, insertInto: context)
        newItem.setValue(numberOfToDos + 1, forKey: ToDoItemEnum.id.rawValue)
        newItem.setValue(title, forKey: ToDoItemEnum.title.rawValue)
        newItem.setValue(detail, forKey: ToDoItemEnum.detail.rawValue)
        newItem.setValue(Date(), forKey: ToDoItemEnum.startDate.rawValue)
        newItem.setValue(endDate, forKey: ToDoItemEnum.endDate.rawValue)
        newItem.setValue(false, forKey: ToDoItemEnum.completed.rawValue)
        newItem.setValue(color, forKey: ToDoItemEnum.color.rawValue)
        contextSave()
    }
    
    func updateItem(todoId id: Int, title: String, detail: String, endDate: Date?, color: UIColor) {
        var toDo: ToDoItem
        let fetchToDo: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        fetchToDo.predicate = NSPredicate(format: "\(ToDoItemEnum.id.rawValue) == %d", id as Int)
        let results = try? context.fetch(fetchToDo)
        if results?.count == 0 {
            toDo = ToDoItem(context: context)
        } else {
            toDo = (results?.first)!
        }
        toDo.title = title
        toDo.detail = detail
        toDo.endDate = endDate
        toDo.color = color
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
    
    func getItemFromId(todoId id: Int) -> ToDo {
        var item: NSManagedObject
        let fetchToDo: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        fetchToDo.predicate = NSPredicate(format: "\(ToDoItemEnum.id.rawValue) == %d", id as Int)
        let results = try? context.fetch(fetchToDo)
        if results?.count == 0 {
            item = ToDoItem(context: context)
        } else {
            item = (results?.first)!
        }
        let toDo =  createToDoFromNSManagedObject(managedObject: item)
        return toDo
    }
    
    private func createToDoFromNSManagedObject(managedObject item: NSManagedObject) -> ToDo{
        let id = item.value(forKey: ToDoItemEnum.id.rawValue) as! Int
        let title = item.value(forKey: ToDoItemEnum.title.rawValue) as! String
        let startDate = item.value(forKey: ToDoItemEnum.startDate.rawValue) as! Date
        let endDate = item.value(forKey: ToDoItemEnum.endDate.rawValue) as? Date
        let completed = item.value(forKey: ToDoItemEnum.completed.rawValue) as! Bool
        let color = item.value(forKey: ToDoItemEnum.color.rawValue) as! UIColor
        let toDo = ToDo(id: id, title: title, startDate: startDate, endDate: endDate, completed: completed, color: color)
        return toDo
    }
    
    private func contextSave(){
        do {
            try context.save()
        } catch let nserror as NSError {
            print("ERROR: Coredata error \(nserror)")
        }
    }
}

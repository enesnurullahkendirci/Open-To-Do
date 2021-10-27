//
//  CoreDataManager.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 5.10.2021.
//

import CoreData
import UIKit

protocol DataManagerProtocol {
    func getAllItems() -> [ToDo]
    func createItem(title: String, detail: String, endDate: Date?, color: UIColor, completion: @escaping(_ res: Bool, _ id: UUID) -> Void)
    func updateItemComplete(todoId id: UUID)
    func updateItem(todoId id: UUID, title: String, detail: String, endDate: Date?, color: UIColor, completion: @escaping(_ res: Bool) -> Void)
    
    func getItemFromId(todoId id: UUID) -> ToDo
}

class CoreDataManager: DataManagerProtocol {
    
    static let shared = CoreDataManager()
    private init() {}
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        return toDos
    }
    
    func createItem(title: String, detail: String, endDate: Date?, color: UIColor, completion: @escaping(_ res: Bool, _ id: UUID) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: ToDoItemEnum.entityName.rawValue, in: context)
        else { return }
        let newItem = NSManagedObject(entity: entity, insertInto: context)
        let id = UUID()
        newItem.setValue(id, forKey: ToDoItemEnum.id.rawValue)
        newItem.setValue(title, forKey: ToDoItemEnum.title.rawValue)
        newItem.setValue(detail, forKey: ToDoItemEnum.detail.rawValue)
        newItem.setValue(Date(), forKey: ToDoItemEnum.startDate.rawValue)
        newItem.setValue(endDate, forKey: ToDoItemEnum.endDate.rawValue)
        newItem.setValue(false, forKey: ToDoItemEnum.completed.rawValue)
        newItem.setValue(color, forKey: ToDoItemEnum.color.rawValue)
        contextSave { res in
            completion(res, id)
        }
    }
    
    func updateItem(todoId id: UUID, title: String, detail: String, endDate: Date?, color: UIColor, completion: @escaping(_ res: Bool) -> Void) {
        var toDo: ToDoItem
        let fetchToDo: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        fetchToDo.predicate = NSPredicate(format: "id == %@", id as CVarArg)
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
        contextSave { res in
            completion(res)
        }
    }
    
    func updateItemComplete(todoId id: UUID) {
        var toDo: ToDoItem
        let fetchToDo: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        fetchToDo.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        let results = try? context.fetch(fetchToDo)
        if results?.count == 0 {
            toDo = ToDoItem(context: context)
        } else {
            toDo = (results?.first)!
        }
        toDo.completed.toggle()
        contextSave { _ in }
    }
    
    func getItemFromId(todoId id: UUID) -> ToDo {
        var item: ToDoItem
        let fetchToDo: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        fetchToDo.predicate = NSPredicate(format: "id == %@", id as CVarArg)
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
        let id = item.value(forKey: ToDoItemEnum.id.rawValue) as! UUID
        let title = item.value(forKey: ToDoItemEnum.title.rawValue) as! String
        let detail = item.value(forKey: ToDoItemEnum.detail.rawValue) as? String
        let startDate = item.value(forKey: ToDoItemEnum.startDate.rawValue) as! Date
        let endDate = item.value(forKey: ToDoItemEnum.endDate.rawValue) as? Date
        let completed = item.value(forKey: ToDoItemEnum.completed.rawValue) as! Bool
        let color = item.value(forKey: ToDoItemEnum.color.rawValue) as! UIColor
        let toDo = ToDo(id: id, title: title, detail: detail, startDate: startDate, endDate: endDate, completed: completed, color: color)
        return toDo
    }
    
    private func contextSave(completion: @escaping(_ res: Bool) -> Void){
        do {
            try context.save()
            completion(true)
        } catch let nserror as NSError {
            completion(false)
            print("ERROR: Coredata error \(nserror)")
        }
    }
}

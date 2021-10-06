//
//  ListedInteractor.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//

import Foundation

protocol ListedInteractorType {
    var presenter: ListedPresenterType? {get set}
    
    func fetchTodos(ascending: Bool)
    func updateCompleted(itemId id: Int, ascending: Bool)
}

class ListedInteractor: ListedInteractorType {
    var presenter: ListedPresenterType?
    private var coreDataManager = CoreDataManager()
    
    func fetchTodos(ascending: Bool) {
        var coreDataManager = CoreDataManager()
        let toDos: [ToDo] = coreDataManager.getAllItems()
        var completedToDo: [ToDo] = []
        var uncompletedToDo: [ToDo] = []
        for todo in toDos {
            if todo.completed {
                completedToDo.append(todo)
            }else {
                uncompletedToDo.append(todo)
            }
        }
        if !ascending {
            completedToDo.reverse()
            uncompletedToDo.reverse()
        }
        guard let presenter = self.presenter else { return }
        presenter.onTodosFetched(toDos: [uncompletedToDo, completedToDo])
    }
    
    func updateCompleted(itemId id: Int, ascending: Bool) {
        coreDataManager.updateItemComplete(todoId: id)
        fetchTodos(ascending: ascending)
    }
}

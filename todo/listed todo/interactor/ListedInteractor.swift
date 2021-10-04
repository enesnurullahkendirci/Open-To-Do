//
//  ListedInteractor.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//

import Foundation

protocol ListedInteractorType {
    var presenter: ListedPresenterType? {get set}
    
    func fetchTodos()
}

class ListedInteractor: ListedInteractorType {
    var presenter: ListedPresenterType?

    func fetchTodos() {
        var toDos: [ToDo] = []
        for i in 0...5{
            toDos.append(ToDo(id: i, title: "Elma al", startDate: Calendar.current.date(byAdding: .day, value: -2*i, to: Date())!, endDate: Date(), completed: true))
        }
        for i in 0...3{
            toDos.append(ToDo(id: i + 10, title: "Elma Ye", startDate: Calendar.current.date(byAdding: .day, value: -i, to: Date())!, endDate: Calendar.current.date(byAdding: .day, value: 10 + i, to: Date())!, completed: false))
        }
        var completedToDo: [ToDo] = []
        var uncompletedToDo: [ToDo] = []
        for todo in toDos {
            if todo.completed {
                completedToDo.append(todo)
            }else {
                uncompletedToDo.append(todo)
            }
        }
        guard let presenter = self.presenter else { return }
        presenter.onTodosFetched(toDos: [uncompletedToDo, completedToDo])
    }
}

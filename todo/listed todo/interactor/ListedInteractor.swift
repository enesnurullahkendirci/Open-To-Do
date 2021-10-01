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
            toDos.append(ToDo(id: i, title: "Elma al", startDate: Date(), endDate: Date(), completed: true))
        }
        for i in 0...3{
            toDos.append(ToDo(id: i + 10, title: "Elma Ye", startDate: Date(), endDate: Date(), completed: false))
        }
        self.presenter?.onTodosFetched(toDos: toDos)
    }
}

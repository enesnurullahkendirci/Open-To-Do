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
        for _ in 0...5{
            toDos.append(ToDo(title: "Elma al", startDate: Date(), endDate: Date(), complete: true))
        }
        self.presenter?.onTodosFetched(toDos: toDos)
    }
}

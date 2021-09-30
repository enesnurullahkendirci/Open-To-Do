//
//  ListedInteractor.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//

import Foundation

protocol ListedInteractorType {
    var interactorDelegate: ListedInteractorDelegate? { get set }
    
    func fetchTodos()
}

protocol ListedInteractorDelegate: AnyObject {
    func onTodosFetched(toDos: [ToDo])
}

class ListedInteractor: ListedInteractorType {
    
    weak var interactorDelegate: ListedInteractorDelegate?

    func fetchTodos() {
        var toDos: [ToDo] = []
        for i in 0...5{
            toDos.append(ToDo(title: "elma al", date: i, complete: false))
        }
        self.interactorDelegate?.onTodosFetched(toDos: toDos)
    }
    
    
}

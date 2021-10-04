//
//  ListedPresenter.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//

import Foundation
import UIKit

protocol ListedPresenterType {
    
    var view: ListedViewControllerType? {get set}
    var interactor: ListedInteractorType? {get set}
    var router: ListedRouterType? {get set}
    
    func onListedPresenter()
    func onTodosFetched(toDos: [[ToDo]])
    func editToDo(tag id: Int, toDos: [[ToDo]], completed: Bool)
    func didSelect(on view: ListedViewControllerType, color: UIColor)
}

class ListedPresenter: ListedPresenterType {
    
    var view: ListedViewControllerType?
    var interactor: ListedInteractorType?
    var router: ListedRouterType?
    
    func onListedPresenter() {
        self.interactor?.fetchTodos()
    }
    
    func onTodosFetched(toDos: [[ToDo]]) {
        guard let view = self.view else {
            print("listedpresenter -> listedview nil")
            return
        }
        view.onTodosFetched(toDos: toDos)
    }
    
    func editToDo(tag id: Int, toDos: [[ToDo]], completed: Bool)  {
        var funcToDos: [[ToDo]] = toDos
        if completed {
            if let todoIndex = toDos[1].firstIndex(where: {$0.id == id}) {
                var toDo = toDos[1][todoIndex]
                toDo.completed.toggle()
                funcToDos[0].append(toDo)
                funcToDos[1].remove(at: todoIndex)
            }
        }else {
            if let todoIndex = toDos[0].firstIndex(where: {$0.id == id}) {
                var toDo = toDos[0][todoIndex]
                toDo.completed.toggle()
                funcToDos[1].append(toDo)
                funcToDos[0].remove(at: todoIndex)
            }
        }
        view!.onTodosFetched(toDos: funcToDos)
    }
    
    func didSelect(on view: ListedViewControllerType, color: UIColor) {
        router?.pushToDetail(on: view, color: color)
    }
}

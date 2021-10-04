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
    func sort(toDo: [[ToDo]], sortByEndDate: Bool)
}

class ListedPresenter: ListedPresenterType {
    
    var view: ListedViewControllerType?
    var interactor: ListedInteractorType?
    var router: ListedRouterType?
    
    func onListedPresenter() {
        guard let interactor = interactor else { return }
        interactor.fetchTodos()
    }
    
    func onTodosFetched(toDos: [[ToDo]]) {
        guard let view = self.view else { return }
        view.onTodosFetched(toDos: toDos)
    }
    
    func didSelect(on view: ListedViewControllerType, color: UIColor) {
        guard let router = router else { return }
        router.pushToDetail(on: view, color: color)
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
        guard let view = self.view else { return }
        view.onTodosFetched(toDos: funcToDos)
    }
    
    func sort(toDo: [[ToDo]], sortByEndDate: Bool) {
        var todo0: [ToDo]?
        var todo1: [ToDo]?
        if sortByEndDate {
            todo0 = toDo[0].sorted(by: { $0.endDate.compare($1.endDate) == .orderedDescending })
            todo1 = toDo[1].sorted(by: { $0.endDate.compare($1.endDate) == .orderedDescending })
        } else {
            todo0 = toDo[0].sorted(by: { $0.startDate.compare($1.startDate) == .orderedDescending })
            todo1 = toDo[1].sorted(by: { $0.startDate.compare($1.startDate) == .orderedDescending })
        }
        onTodosFetched(toDos: [todo0!, todo1!])
    }
}

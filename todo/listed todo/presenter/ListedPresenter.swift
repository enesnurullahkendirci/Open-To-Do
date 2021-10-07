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
    
    func onListedPresenter(ascending: Bool)
    func updateCompleted(tag id: Int, ascending: Bool)
    func didSelect(on view: ListedViewControllerType, color: UIColor)
    func toDosFilter(toDos: [[ToDo]], searchText: String) -> [[ToDo]]
    
    func onTodosFetched(toDos: [[ToDo]])
}

class ListedPresenter: ListedPresenterType {
    
    var view: ListedViewControllerType?
    var interactor: ListedInteractorType?
    var router: ListedRouterType?
    
}

//MARK: - ListedPresenterType View Methods
extension ListedPresenter {
    func onListedPresenter(ascending: Bool) {
        guard let interactor = interactor else { return }
        interactor.fetchTodos(ascending: ascending)
    }
    func didSelect(on view: ListedViewControllerType, color: UIColor) {
        guard let router = router else { return }
        router.pushToDetail(on: view, color: color)
    }
    
    func updateCompleted(tag id: Int, ascending: Bool) {
        guard let interactor = interactor else { return }
        interactor.updateCompleted(itemId: id, ascending: ascending)
    }
    
    func toDosFilter(toDos: [[ToDo]], searchText: String) -> [[ToDo]] {
        let searchedToDos0 = toDos[0].filter { $0.title.lowercased().prefix(searchText.count) == searchText.lowercased() }
        let searchedToDos1 = toDos[1].filter { $0.title.lowercased().prefix(searchText.count) == searchText.lowercased() }
        return [searchedToDos0, searchedToDos1]
    }
}

//MARK: - ListedPresenterType Interactor Methods
extension ListedPresenter{
    func onTodosFetched(toDos: [[ToDo]]) {
        guard let view = self.view else { return }
        view.onTodosFetched(toDos: toDos)
    }
}

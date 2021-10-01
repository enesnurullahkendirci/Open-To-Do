//
//  ListedPresenter.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//

import Foundation

protocol ListedPresenterType {
    
    var view: ListedViewControllerType? {get set}
    var interactor: ListedInteractorType? {get set}
    var router: ListedRouterType? {get set}
    
    func onListedPresenter()
    func onTodosFetched(toDos: [ToDo])
    func dateToString(dates: [Date]) -> [String]
}

class ListedPresenter: ListedPresenterType {
    
    var view: ListedViewControllerType?
    var interactor: ListedInteractorType?
    var router: ListedRouterType?
    
    func onListedPresenter() {
        self.interactor?.fetchTodos()
    }
    
    func onTodosFetched(toDos: [ToDo]) {
        guard let view = self.view else {
            print("listedpresenter -> listedview nil")
            return
        }
        view.onTodosFetched(toDos: toDos)
    }
    
    func dateToString(dates: [Date]) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd/MM/YY"
        var stringDates: [String] = []
        for date in dates{
            stringDates.append(dateFormatter.string(from: date))
        }
        return stringDates
    }
}

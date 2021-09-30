//
//  ListedPresenter.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//

import Foundation

protocol ListedPresenterType {
    func onListedPresenter(on listedView: ListedViewControllerType)
}

class ListedPresenter {
    
    var interactor = ListedInteractor()
    weak var listedView: ListedViewControllerType?
    
    init() {
        interactor.interactorDelegate = self
    }
    
}

extension ListedPresenter: ListedPresenterType{
    
    func onListedPresenter(on listedView: ListedViewControllerType) {
//        interactor.interactorDelegate = self
        self.listedView = listedView
        self.interactor.fetchTodos()
    }
}

extension ListedPresenter: ListedInteractorDelegate{
    func onTodosFetched(toDos: [ToDo]) {
        guard let listedView = self.listedView else {
            print("listedpresenter -> listedview nil")
            return
        }
        listedView.onTodosFetched(toDos: toDos)
    }
}

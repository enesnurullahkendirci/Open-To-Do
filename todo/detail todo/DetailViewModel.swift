//
//  DetailViewModel.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 8.10.2021.
//

import Foundation

protocol DetailViewModelType {
    func getToDo(id: Int) -> ToDo
}

class DetailViewModel: DetailViewModelType {
    private var coreDataManager: CoreDataManagerProtocol = CoreDataManager()
    
    func getToDo(id: Int) -> ToDo {
        let toDo = coreDataManager.getItemFromId(todoId: id)
        return toDo
    }
}

//
//  DetailViewModel.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 8.10.2021.
//

import UIKit

protocol DetailViewModelType {
    func getToDo(id: Int) -> ToDo
    func saveUpdateButtonClicked(id: Int?, title: String, detail: String, endDate: Date?, color: UIColor, completion: @escaping(_ res: Bool) -> Void)
}

class DetailViewModel: DetailViewModelType {
    private var coreDataManager: DataManagerProtocol = CoreDataManager.shared
    
    func getToDo(id: Int) -> ToDo {
        let toDo = coreDataManager.getItemFromId(todoId: id)
        return toDo
    }
    
    func saveUpdateButtonClicked(id: Int?, title: String, detail: String, endDate: Date?, color: UIColor, completion: @escaping(_ res: Bool) -> Void) {
        guard let id = id else {
            coreDataManager.createItem(title: title, detail: detail, endDate: endDate, color: color){ res in
                completion(res)
            }
            return
        }
        coreDataManager.updateItem(todoId: id, title: title, detail: detail, endDate: endDate, color: color){ res in
            completion(res)
        }
    }
}

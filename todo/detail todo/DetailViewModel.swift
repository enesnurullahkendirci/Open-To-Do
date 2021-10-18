//
//  DetailViewModel.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 8.10.2021.
//

import UIKit

protocol DetailViewModelType {
    func getToDo(id: UUID) -> ToDo
    func saveUpdateButtonClicked(id: UUID?, title: String, detail: String, endDate: Date?, color: UIColor, completion: @escaping(_ res: Bool) -> Void)
    func dismiss(_ view: UIViewController)
}

class DetailViewModel: DetailViewModelType {
    private let coreDataManager: DataManagerProtocol = CoreDataManager.shared
    private let localNotificationManager: NotificationManager = LocalNotificationManager.shared
    
    func getToDo(id: UUID) -> ToDo {
        let toDo = coreDataManager.getItemFromId(todoId: id)
        return toDo
    }
    
    func saveUpdateButtonClicked(id: UUID?, title: String, detail: String, endDate: Date?, color: UIColor, completion: @escaping(_ res: Bool) -> Void) {
        guard let id = id else {
            coreDataManager.createItem(title: title, detail: detail, endDate: endDate, color: color) { res, id in
                completion(res)
                guard let endDate = endDate else { return }
                res ? self.createNotification(id: id, title: title, endDate: endDate) : nil
            }
            return
        }
        coreDataManager.updateItem(todoId: id, title: title, detail: detail, endDate: endDate, color: color){ res in
            completion(res)
            guard let endDate = endDate else { return }
            res ? self.createNotification(id: id, title: title, endDate: endDate) : nil
        }
    }
    
    func dismiss(_ view: UIViewController) {
        view.dismiss(animated: true, completion: nil)
    }
    
    private func createNotification(id: UUID, title: String, endDate: Date){
        localNotificationManager.createNotification(id: id, title: title, endDate: endDate)
    }
}

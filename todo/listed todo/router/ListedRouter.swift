//
//  ListedRouter.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//

import UIKit

typealias EntryPoint = ListedViewControllerType & UIViewController

protocol ListedRouterType {
    var entry: EntryPoint? { get }
    
    static func start() -> ListedRouterType
    func pushToDetail(on view: ListedViewControllerType, todoId id: Int?)
}

class ListedRouter: ListedRouterType {
    var entry: EntryPoint?
    
    static func start() -> ListedRouterType {
        let router = ListedRouter()
        
        let view: EntryPoint = ListedViewController()
        var presenter: ListedPresenterType = ListedPresenter()
        var interactor: ListedInteractorType = ListedInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        router.entry = view as EntryPoint
        
        return router
    }
    
    func pushToDetail(on view: ListedViewControllerType,todoId id: Int?) {
        let detailViewController = DetailViewController(todoId: id)
        let viewController = view as! ListedViewController
        viewController.present(detailViewController, animated: true, completion: nil)
    }
    
    
}

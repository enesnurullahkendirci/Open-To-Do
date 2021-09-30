//
//  ViewController.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//

import UIKit

protocol ListedViewControllerType: AnyObject {
    func onTodosFetched(toDos: [ToDo])
}

class ListedViewController: UIViewController {
    var toDos: [ToDo]?
    var presenter: ListedPresenterType?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ListedPresenter()
        if presenter != nil {
            self.presenter!.onListedPresenter(on: self)
        } else { //delete
            print("presenter nil")
        }
    }
}

extension ListedViewController: ListedViewControllerType{
    func onTodosFetched(toDos: [ToDo]) {
        self.toDos = toDos
        print("todos = ", toDos)
        self.tableView.reloadData()
    }
}

extension ListedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let toDo = toDos?[indexPath.row]
        cell.textLabel?.text = toDo?.title
        cell.detailTextLabel?.text = String(toDo?.date ?? 0)
        return cell
    }
    
    
}

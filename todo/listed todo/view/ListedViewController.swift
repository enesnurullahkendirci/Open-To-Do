//
//  ViewController.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//

import UIKit

protocol ListedViewControllerType: AnyObject {
    var presenter: ListedPresenterType? {get set}
    
    func onTodosFetched(toDos: [ToDo])
}

class ListedViewController: UIViewController {
    var toDos: [ToDo]?
    var presenter: ListedPresenterType?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "customToDoCell")
        if presenter != nil {
            self.presenter!.onListedPresenter()
        } else { //delete
            print("presenter nil")
        }
    }
    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        let detailViewController = DetailViewController()
        detailViewController.modalPresentationStyle = .popover
        self.present(detailViewController, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "customToDoCell") as! ToDoTableViewCell
        let toDo = toDos?[indexPath.row]
        cell.todoText.text = toDo?.title
        cell.detailTextLabel?.text = String(toDo?.date ?? 0)
        return cell
    }
    
    
}

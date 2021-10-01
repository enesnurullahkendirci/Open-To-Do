//
//  ViewController.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//

import UIKit

protocol ListedViewControllerType: AnyObject {
    var presenter: ListedPresenterType? {get set}
    
    func onTodosFetched(toDos: [[ToDo]])
}

class ListedViewController: UIViewController {
    var toDos: [[ToDo]]?
    var presenter: ListedPresenterType?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "customToDoCell")
        if presenter != nil {
            self.presenter!.onListedPresenter()
        }
    }
    
    @IBAction func addClicked(_ sender: UIBarButtonItem) { // MOVE IT!
        let detailViewController = DetailViewController()
        detailViewController.modalPresentationStyle = .popover
        self.present(detailViewController, animated: true, completion: nil)
    }
}

extension ListedViewController: ListedViewControllerType{
    func onTodosFetched(toDos: [[ToDo]]) {
        self.toDos = toDos
        print("todos = ", toDos)
        self.tableView.reloadData()
    }
}

extension ListedViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return toDos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customToDoCell") as! ToDoTableViewCell
        let toDo = toDos?[indexPath.section][indexPath.row]
        cell.todoText.text = toDo?.title
        let dateArray: [Date] = [toDo?.startDate ?? Date(), toDo?.endDate ?? Date()]
        let dates: [String] = (presenter?.dateToString(dates: dateArray))!
        cell.startDate.text = dates[0]
        cell.endDate.text = dates[1]
        cell.checked = toDo?.completed
        cell.setImage()
        
        guard let id = toDo?.id else { return cell }
        cell.checkButton.tag = id
        cell.checkButton.addTarget(self, action: #selector(cellCheckButtonClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func cellCheckButtonClicked(sender: UIButton!) {
        
        if sender.image(for: .normal) == UIImage(systemName: "checkmark.seal") {
            self.presenter?.editToDo(tag: sender.tag,toDos: toDos!, completed: false)
        } else {
            self.presenter?.editToDo(tag: sender.tag,toDos: toDos!, completed: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerTitles = ["To-Do", "Completed"]
        return headerTitles[section]
    }
}



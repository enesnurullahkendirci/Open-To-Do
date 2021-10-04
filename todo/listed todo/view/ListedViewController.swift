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
    var sortByEndDate = true
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "customToDoCell")
        guard let presenter = presenter else { return }
        presenter.onListedPresenter()
    }
    
    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        guard let presenter = presenter else { return }
        presenter.didSelect(on: self, color: UIColor.systemCyan) //route to detail with random data.
    }
    
    @IBAction func sort(_ sender: UIBarButtonItem) {
        guard let toDos = toDos else { return }
        guard let presenter = presenter else { return }
        presenter.sort(toDo: toDos, sortByEndDate: sortByEndDate)
        sortByEndDate.toggle()
    }
}

extension ListedViewController: ListedViewControllerType{
    func onTodosFetched(toDos: [[ToDo]]) {
        self.toDos = toDos
        self.tableView.reloadData()
    }
}

extension ListedViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let toDos = toDos else { return 0 }
        if toDos[0].count == 0 && toDos[1].count == 0 {
            navigationBar.topItem?.title = "Add some To-Do"
            return 0
        }
        navigationBar.topItem?.title = "Good Luck with To-Do."
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let toDos = toDos else { return 0 }
        return toDos[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customToDoCell") as! ToDoTableViewCell
        guard let toDos = toDos else { return cell }
        let toDo = toDos[indexPath.section][indexPath.row]
        cell.toDo = toDo
        cell.configureCell()
        cell.checkButton.addTarget(self, action: #selector(cellCheckButtonClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func cellCheckButtonClicked(sender: UIButton!) {
        guard let presenter = self.presenter else { return }
        guard let toDos = toDos else { return }
        if sender.image(for: .normal) == UIImage(systemName: SystemImages.unchecked.rawValue) {
            presenter.editToDo(tag: sender.tag, toDos: toDos, completed: false)
        } else if sender.image(for: .normal) == UIImage(systemName: SystemImages.checked.rawValue) {
            presenter.editToDo(tag: sender.tag, toDos: toDos, completed: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerTitles = ["To-Do", "Completed"]
        return headerTitles[section]
    }
}


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
    var searchedToDos: [[ToDo]]?
    var presenter: ListedPresenterType?
    var searching: Bool = false
    var ascending = true
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        tableView.register(UINib(nibName: TodoCell.name.rawValue, bundle: nil), forCellReuseIdentifier: TodoCell.identifier.rawValue)
        guard let presenter = presenter else { return }
        presenter.onListedPresenter(ascending: ascending)
        searchBar.searchTextField.clearButtonMode = .never

    }
    
    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        guard let presenter = presenter else { return }
        presenter.didSelect(on: self, todoId: nil)
    }
    
    @IBAction func sort(_ sender: UIBarButtonItem) {
        guard let presenter = presenter else { return }
        ascending.toggle()
        presenter.onListedPresenter(ascending: ascending)

    }
}

extension ListedViewController: ListedViewControllerType{
    func onTodosFetched(toDos: [[ToDo]]) {
        if searching {
            guard let presenter = presenter else { return }
            searchedToDos = presenter.toDosFilter(toDos: toDos, searchText: searchBar.text!)
        }
        self.toDos = toDos
        self.tableView.reloadData()
    }
}

extension ListedViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let toDos = toDos else { return 0 }
        if toDos[0].count == 0 {
            navigationBar.topItem?.title = ListScreenLanguageEnum.titleEmpty.rawValue.localized()
            return (toDos[1].count > 0 ? 2 : 0)
        }
        navigationBar.topItem?.title = ListScreenLanguageEnum.titleNotEmpty.rawValue.localized()
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let toDos = getArray()
        return toDos[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDos = getArray()
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier.rawValue) as! ToDoTableViewCell
        let toDo = toDos[indexPath.section][indexPath.row]
        cell.toDo = toDo
        cell.configureCell()
        cell.checkButton.addTarget(self, action: #selector(cellCheckButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ToDoTableViewCell {
            guard let todo = cell.toDo else { return }
            let id = todo.id
            guard let presenter = presenter else { return }
            presenter.didSelect(on: self, todoId: id)
        }
    }
    
    @objc func cellCheckButtonClicked(sender: UIButton!) {
        guard let presenter = self.presenter else { return }
        presenter.updateCompleted(tag: sender.tag, ascending: ascending)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerTitles = ["To-Do", "Completed".localized()]
        return headerTitles[section]
    }
    
    private func getArray() -> [[ToDo]]{
        return searching ? searchedToDos! : toDos!
    }
}

extension ListedViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let toDos = toDos else { return }
        guard let presenter = presenter else { return }
        searchBar.setShowsCancelButton(true, animated: true)
        searchedToDos = presenter.toDosFilter(toDos: toDos, searchText: searchText)
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

extension ListedViewController: ListedVCDelegateProtocol {
    func didAnyUpdate(res: Bool) {
        guard let presenter = presenter else { return }
        res ? presenter.onListedPresenter(ascending: ascending) : nil
    }
}

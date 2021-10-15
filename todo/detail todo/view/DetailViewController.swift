//
//  DetailViewController.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 1.10.2021.
//

import UIKit

protocol ListedVCDelegateProtocol: NSObject {
    func didAnyUpdate(res: Bool)
}

class DetailViewController: UIViewController {
    weak var delegate: ListedVCDelegateProtocol? = nil
    private var detailViewModel: DetailViewModelType = DetailViewModel()
    private var todoId: Int?
    
    @IBOutlet weak var detailScreenTitle: UILabel!
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var datePicker: UITextField!
    @IBOutlet var colorButtons: [UIButton]!
    @IBOutlet weak var saveUpdateButton: UIButton!
    
    override func viewDidLoad() {
        configureScreen()
        super.viewDidLoad()
    }
    
    init(todoId id: Int?) {
        self.todoId = id
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func colorButtonClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = UIColor().TagToColor(tag: sender.tag)
        }
        for colorButton in colorButtons {
            colorButton.setImage(UIImage(systemName: DetailColorPickerImages.unselected.rawValue), for: .normal)
        }
        sender.setImage(UIImage(systemName: DetailColorPickerImages.selected.rawValue), for: .normal)
    }
    
    @IBAction func saveUpdateButtonClicked(_ sender: UIButton) {
        guard let title = todoTitle.text else { return }
        guard let detail = detailTextView.text else { return }
        var endDate: Date?
        if datePicker.text != "" {
            endDate = picker.date
        }
        guard let color = view.backgroundColor else { return }
        detailViewModel.saveUpdateButtonClicked(id: todoId, title: title, detail: detail, endDate: endDate, color: color) { res in
            guard let delegate = self.delegate else { return }
            delegate.didAnyUpdate(res: res)
            res ? self.dismiss(animated: true, completion: nil) : print(res)
        }
    }
    
    private func configureScreen(){
        createDatePicker()
        guard let todoId = todoId else {
            detailScreenTitle.text = "Add To-Do"
            return
        }
        let toDo = detailViewModel.getToDo(id: todoId)
        view.backgroundColor = toDo.color
        detailScreenTitle.text = toDo.title
        todoTitle.text = toDo.title
        detailTextView.text = toDo.detail != nil ? toDo.detail : ""
        datePicker.text = toDo.endDate != nil ? toDo.endDate!.dateToString() : ""
        for button in colorButtons {
            if button.tag == toDo.color.ColorToTag() {
                button.setImage(UIImage(systemName: DetailColorPickerImages.selected.rawValue), for: .normal)
            }
            else {
                button.setImage(UIImage(systemName: DetailColorPickerImages.unselected.rawValue), for: .normal)
            }
        }
        saveUpdateButton.setTitle("Update To-Do", for: .normal)
        saveUpdateButton.isUserInteractionEnabled = true
        saveUpdateButton.backgroundColor = .systemYellow
    }
    
    private let picker = UIDatePicker()
    private func createDatePicker() {
        picker.datePickerMode = .dateAndTime
        picker.minimumDate = Date()
        picker.preferredDatePickerStyle = .wheels
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: #selector(undoClicked))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([clearButton, space, doneButton], animated: true)
        datePicker.inputAccessoryView = toolbar
        datePicker.inputView = picker
    }
    @objc private func undoClicked(){
        datePicker.text = ""
        self.view.endEditing(true)
    }
    @objc private func doneClicked(){
        datePicker.text = picker.date.dateToString()
        self.view.endEditing(true)
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        saveUpdateButton.isUserInteractionEnabled = !text.isEmpty
        UIButton.animate(withDuration: 0.5) {
            self.saveUpdateButton.backgroundColor =  text.isEmpty ? .systemGray : .systemYellow
        }
    }
}

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
    private var todoId: UUID?
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet var colorButtons: [UIButton]!
    @IBOutlet weak var saveUpdateButton: UIButton!
    
    private let endDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
        createDatePicker()
        configureScreen()
        super.viewDidLoad()
    }
    
    init(todoId id: UUID?) {
        self.todoId = id // if id not equal nil detailScreen opened from cell. If id equal to nil opened from +(add) button.
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func colorButtonClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            let color = UIColor().TagToColor(tag: sender.tag)
            self.navigationBar.barTintColor = color
            self.navigationBar.layoutIfNeeded()
            self.saveUpdateButton.isUserInteractionEnabled ? self.saveUpdateButton.backgroundColor = color : nil
        }
        for colorButton in colorButtons {
            colorButton.setImage(UIImage(systemName: DetailColorPickerImages.unselected.rawValue), for: .normal)
        }
        sender.setImage(UIImage(systemName: DetailColorPickerImages.selected.rawValue), for: .normal)
    }
    
    @IBAction func saveUpdateButtonClicked(_ sender: UIButton) {
        guard let title = titleTextField.text else { return }
        guard let detail = detailTextView.text else { return }
        let endDate = endDateTextField.text == "" ? nil : endDatePicker.date
        guard let color = navigationBar.barTintColor else { return }
        detailViewModel.saveUpdateButtonClicked(id: todoId, title: title, detail: detail, endDate: endDate, color: color) { res in
            guard let delegate = self.delegate else { return }
            delegate.didAnyUpdate(res: res)
            res ? self.detailViewModel.dismiss(self) : print(res)
        }
    }
    
    private func configureScreen(){
        titleTextField.placeholder = DetailScreenLanguageEnum.titleTextFieldPlaceHolder.rawValue.localized()
        endDateTextField.placeholder = DetailScreenLanguageEnum.endDateTextFieldPlaceHolder.rawValue.localized()
        guard let todoId = todoId else {
            configureDefault()
            return
        }
        configureForUpdate(todoId)
    }
    
    private func configureDefault() {
        navigationBar.topItem?.title = DetailScreenLanguageEnum.navigationTitle.rawValue.localized()
        saveUpdateButton.setTitle(DetailScreenLanguageEnum.saveButtonText.rawValue.localized(), for: .normal)
    }
    
    private func configureForUpdate(_ todoId: UUID){
        let toDo = detailViewModel.getToDo(id: todoId)
        navigationBar.barTintColor = toDo.color
        navigationBar.topItem?.title = toDo.title
        titleTextField.text = toDo.title
        detailTextView.text = toDo.detail != nil ? toDo.detail : ""
        endDateTextField.text = toDo.endDate != nil ? toDo.endDate!.dateToString() : ""
        for button in colorButtons {
            if button.tag == toDo.color.ColorToTag() {
                button.setImage(UIImage(systemName: DetailColorPickerImages.selected.rawValue), for: .normal)
            }
            else {
                button.setImage(UIImage(systemName: DetailColorPickerImages.unselected.rawValue), for: .normal)
            }
        }
        saveUpdateButton.setTitle(DetailScreenLanguageEnum.updateButtonText.rawValue.localized(), for: .normal)
        saveUpdateButton.isUserInteractionEnabled = true
        saveUpdateButton.backgroundColor = toDo.color
    }
    
    private func createDatePicker() {
        endDatePicker.datePickerMode = .dateAndTime
        endDatePicker.minimumDate = Date()
        endDatePicker.preferredDatePickerStyle = .wheels
        let toolbar = createToolBar()
        endDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputView = endDatePicker
    }
    
    private func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: #selector(undoClicked))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([clearButton, space, doneButton], animated: true)
        return toolbar
    }
    
    @objc private func undoClicked(){
        endDateTextField.text = ""
        self.view.endEditing(true)
    }
    @objc private func doneClicked(){
        endDateTextField.text = endDatePicker.date.dateToString()
        self.view.endEditing(true)
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        saveUpdateButton.isUserInteractionEnabled = !text.isEmpty
        UIButton.animate(withDuration: 0.5) {
            self.saveUpdateButton.backgroundColor =  text.isEmpty ? .systemGray : self.navigationBar.barTintColor
        }
    }
}

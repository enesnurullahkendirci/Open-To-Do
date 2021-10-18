//
//  ToDoTableViewCell.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 1.10.2021.
//

import UIKit

protocol CellDelegateProtocol: NSObject {
    func checkButtonClicked(id: UUID)
}

class ToDoTableViewCell: UITableViewCell {
    weak var delegate: CellDelegateProtocol? = nil
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var todoText: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var toDo: ToDo?
    var checked: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 10
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        guard let id = toDo?.id else { return }
        guard let delegate = delegate else { return }
        delegate.checkButtonClicked(id: id)
    }
    
    func setImage() {
        guard let checkedImage = UIImage(systemName: ListedCheckImages.checked.rawValue) else { return }
        guard let uncheckedImage = UIImage(systemName: ListedCheckImages.unchecked.rawValue) else { return }
        guard let checked = checked else { return }
        checked ? checkButton.setImage(checkedImage, for: .normal) : checkButton.setImage(uncheckedImage, for: .normal)
    }
    
    func configureCell() {
        guard let toDo = self.toDo else { return }
        view.backgroundColor = toDo.color
        todoText.text = toDo.title
        startDate.text = toDo.startDate.dateToString()
        endDate.text = toDo.endDate == nil ? "" : toDo.endDate?.dateToString()
        checkButton.setTitle("", for: .normal)
        checked = toDo.completed
        setImage()
    }
}

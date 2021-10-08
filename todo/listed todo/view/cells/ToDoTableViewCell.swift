//
//  ToDoTableViewCell.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 1.10.2021.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setImage() {
        guard let checkedImage = UIImage(systemName: SystemImages.checked.rawValue) else { return }
        guard let uncheckedImage = UIImage(systemName: SystemImages.unchecked.rawValue) else { return }
        guard let checked = checked else { return }
        checked ? checkButton.setImage(checkedImage, for: .normal) : checkButton.setImage(uncheckedImage, for: .normal)
    }
    
    func configureCell() {
        guard let toDo = self.toDo else { return }
        view.backgroundColor = toDo.color
        todoText.text = toDo.title
        startDate.text = toDo.startDate.dateToString()
        if toDo.endDate == nil{
            endDate.text = ""
        } else {
            endDate.text = toDo.endDate?.dateToString()
        }
        checkButton.tag = toDo.id
        checked = toDo.completed
        setImage()
    }
}

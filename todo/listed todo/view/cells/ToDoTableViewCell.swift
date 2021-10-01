//
//  ToDoTableViewCell.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 1.10.2021.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoText: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var id: Int?
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
        guard let checkedImage = UIImage(systemName: "checkmark.seal.fill") else { return }
        guard let uncheckedImage = UIImage(systemName: "checkmark.seal") else { return }
        checked! ? checkButton.setImage(checkedImage, for: .normal) : checkButton.setImage(uncheckedImage, for: .normal)
    }
}

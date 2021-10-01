//
//  ToDoTableViewCell.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 1.10.2021.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

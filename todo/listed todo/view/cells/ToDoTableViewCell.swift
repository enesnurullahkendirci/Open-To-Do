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
        guard let image = UIImage(systemName: "checkmark.seal.fill") else { return }
        checked! ? checkButton.setImage(image, for: .normal) : nil
    }
    
    @IBAction func checkClicked(_ sender: UIButton) {
        if sender.image(for: .normal) == UIImage(named: "checkmark.seal") {
            guard let image = UIImage(systemName: "checkmark.seal.fill") else { return }
            sender.setImage(image, for: .normal)
        }
    }
}

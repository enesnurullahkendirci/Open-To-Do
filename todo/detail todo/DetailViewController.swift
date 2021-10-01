//
//  DetailViewController.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 1.10.2021.
//

import UIKit

class DetailViewController: UIViewController {

    var backgroundColor: UIColor //take fake data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
    }

    init(color: UIColor) {
        self.backgroundColor = color
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

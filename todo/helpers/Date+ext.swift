//
//  Date+ext.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 4.10.2021.
//

import Foundation

extension Date{
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd/MM/YY"
        return dateFormatter.string(from: self)
    }
}

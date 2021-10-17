//
//  String+ext.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 17.10.2021.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}

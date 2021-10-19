//
//  UIColor+ext.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 10.10.2021.
//

import UIKit

extension UIColor{
    private var tagColorDictionary: [Int : UIColor] {
        get {
            return [0: .systemRed,
                    1: .systemOrange,
                    2: .systemGreen,
                    3: .systemTeal,
                    4: .systemBlue,
                    5: .systemIndigo,
                    6: .systemPurple,
                    7: .systemPink]
        }
    }
    
    func TagToColor(tag: Int) -> UIColor {
        return tagColorDictionary[tag] ?? .systemRed
    }
    
    func ColorToTag() -> Int {
        guard let val = tagColorDictionary.someKey(forValue: self) else {
            return 0
        }
        return val
    }
}

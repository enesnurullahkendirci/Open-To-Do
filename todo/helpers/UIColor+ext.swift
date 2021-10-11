//
//  UIColor+ext.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 10.10.2021.
//

import UIKit

extension UIColor{
    func TagToColor(tag: Int) -> UIColor {
        switch tag {
        case 0:
            return UIColor.systemRed
        case 1:
            return UIColor.systemOrange
        case 2:
            return UIColor.systemGreen
        case 3:
            return UIColor.systemTeal
        case 4:
            return UIColor.systemBlue
        case 5:
            return UIColor.systemIndigo
        case 6:
            return UIColor.systemPurple
        case 7:
            return UIColor.systemPink
        default:
            return UIColor.systemRed
        }
    }
    
    func ColorToTag() -> Int {
        switch self {
        case UIColor.systemRed:
            return 0
        case UIColor.systemOrange:
            return 1
        case UIColor.systemGreen:
            return 2
        case UIColor.systemTeal:
            return 3
        case UIColor.systemBlue:
            return 4
        case UIColor.systemIndigo:
            return 5
        case UIColor.systemPurple:
            return 6
        case UIColor.systemPurple:
            return 7
        default:
            return 0
        }
    }
}

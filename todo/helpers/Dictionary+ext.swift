//
//  Dictionary+ext.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 16.10.2021.
//

import Foundation

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}

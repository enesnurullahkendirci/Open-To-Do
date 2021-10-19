//
//  ToDo.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 30.09.2021.
//
// develop branch
import UIKit

struct ToDo {
    var id: UUID
    var title: String
    var detail: String?
    var startDate: Date
    var endDate: Date?
    var completed: Bool
    var color: UIColor
}

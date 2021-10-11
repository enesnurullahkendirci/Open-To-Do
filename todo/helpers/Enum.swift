//
//  Constants.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 4.10.2021.
//

import Foundation

enum ListedCheckImages: String {
    case checked = "checkmark.seal.fill"
    case unchecked = "checkmark.seal"
}

enum ToDoItemEnum: String {
    case entityName = "ToDoItem"
    case id = "id"
    case title = "title"
    case detail = "detail"
    case startDate = "startDate"
    case endDate = "endDate"
    case completed = "completed"
    case color = "color"
}

enum TodoCell: String {
    case name = "ToDoTableViewCell"
    case identifier = "customToDoCell"
}

enum DetailColorPickerImages: String {
    case unselected = "circle.fill"
    case selected = "smallcircle.filled.circle"
}

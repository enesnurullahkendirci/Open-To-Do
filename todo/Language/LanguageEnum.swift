//
//  LanguageEnum.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 17.10.2021.
//

import Foundation

enum LanguageEnum: String{
    case tableName = "Localizable"
}

enum ListScreenLanguageEnum: String {
    case titleEmpty = "Add some To-Do"
    case titleNotEmpty = "Good Luck with To-Do"
    case sectionHeader1 = "To-Do"
    case sectionHeader2 = "Completed"
}

enum DetailScreenLanguageEnum: String {
    case navigationTitle = "Add To-Do"
    case titleTextFieldPlaceHolder = "*Title"
    case endDateTextFieldPlaceHolder = "End Date"
    case saveButtonText = "Save To-Do"
    case updateButtonText = "Update To-Do"
}

enum NotificationLanguageEnum: String {
    case body = "To-Do time has expired."
}

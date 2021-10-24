//
//  ItemModel.swift
//  ToDo
//
//  Created by zari on 23/10/2021.
//

import Foundation
import SwiftUI

struct ItemModel: Identifiable, Codable {
    let id: UUID
    let text: String
    let priority: String
    let isCompleted: Bool
    let date: Date
    let category: Int
    
    init(id: UUID = UUID(), text: String, priority: String, isCompleted: Bool, date: Date, category: Int) {
        self.id = id
        self.text = text
        self.priority = priority
        self.isCompleted = isCompleted
        self.date = date
        self.category = category
    }
    
    func changeCompletion() -> ItemModel {
        return ItemModel(id: id, text: text, priority: priority, isCompleted: !isCompleted, date: date, category: category)
    }
}

//
//  ListViewModel.swift
//  ToDo
//
//  Created by zari on 23/10/2021.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItem()
        }
    }
    
    @Published var showToast = false
    let itemsKey: String = "itemsList"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard let data = UserDefaults.standard.data(forKey: itemsKey) else { return }
        guard let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(text: String, priority: String, category: Int, date: Date ) {
        let newItem = ItemModel(text: text, priority: priority, isCompleted: false, date: date, category: category)
        items.append(newItem)
    }
    
    func changeCompletion(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.changeCompletion()
        }
    }
    
    func saveItem() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    let categories: [Category] = [
        Category(name: "Home", textColor: UIColor(red: 0.5804, green: 0.5765, blue: 0.5961, alpha: 1), backgroundColor: UIColor(red: 0.9569, green: 0.8745, blue: 0.3059, alpha: 1), image: "house"),
        Category(name: "Work", textColor: UIColor(red: 0.9882, green: 0.4627, blue: 0.4157, alpha: 1), backgroundColor: UIColor(red: 0.3569, green: 0.5176, blue: 0.6941, alpha: 1), image: "book"),
        Category(name: "Shopping", textColor: UIColor(red: 0, green: 0.1255, blue: 0.2471, alpha: 1), backgroundColor: UIColor(red: 0.6784, green: 0.9373, blue: 0.8196, alpha: 1), image: "cart"),
        Category(name: "Other", textColor: UIColor(red: 0.3725, green: 0.2941, blue: 0.5451, alpha: 1), backgroundColor: UIColor(red: 0.902, green: 0.6039, blue: 0.5529, alpha: 1), image: "person")
    ]
}

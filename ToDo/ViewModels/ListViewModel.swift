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
    
    @Published var showAddedToast = false
    @Published var showDeleteToast = false
    
    let itemsKey: String = "itemsList"
    
    init() {
        getItems()
    }
    
    //SPRAWDZENIE I POBRANIE ISTNIEJACYCH ELEMENTÓW Z PAMIĘCI URZĄDZENIA
    func getItems() {
        guard let data = UserDefaults.standard.data(forKey: itemsKey) else { return }
        guard let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) else { return }
        
        self.items = savedItems
    }
    
    //USUNIĘCIE DANEGO ELEMENTU
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    //ZMIANA POZYCJI W LIŚCIE DANEGO ELEMENTU
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    //DODANIE DANEGO ELEMENTU
    func addItem(text: String, priority: String, category: Int, date: Date ) {
        let newItem = ItemModel(text: text, priority: priority, isCompleted: false, date: date, category: category)
        items.append(newItem)
    }
     
    //ZMIANA WYKONANIA
    func changeCompletion(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.changeCompletion()
            let element = items.remove(at: index)
            items.insert(element, at: items.count)
            
        }
    }
    
    //SORTOWANIE PO DACIE
    func sortByDate() {
        items.sort {
            return $0.date < $1.date
        }
    }
    
    //SORTOWANIE PO KATEGORII
    func sortByCategory() {
        items.sort {
            return $0.category < $1.category
        }
    }
    
    //SORTOWANIE PO PRIORYTECIE 
    func sortByPriority() {
        items.sort {
            if $0.priority == "High" {
                return true
            }
            if $0.priority == "Medium" && $1.priority != "High" {
                return true
            }
            
            return false
        }
    }
    
    //ZAPIS ZMIAN JAKIE NASAPIŁY - DODANIE, USUNIĘCIE, ZMIANA POZYCJI BĄDŹ ZMIANA WYKONANIA
    func saveItem() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    let categories: [Category] = [
        Category(name: "Home", textColor: UIColor(red: 0.098, green: 0.3176, blue: 0.5647, alpha: 1), backgroundColor: UIColor(red: 0.6353, green: 0.6353, blue: 0.6314, alpha: 1), image: "house"),
        Category(name: "Work", textColor: UIColor(red: 0.0627, green: 0.0941, blue: 0.1255, alpha: 1), backgroundColor: UIColor(red: 0.949, green: 0.6667, blue: 0.298, alpha: 1), image: "briefcase"),
        Category(name: "Shopping", textColor: UIColor(red: 0, green: 0.1255, blue: 0.2471, alpha: 1), backgroundColor: UIColor(red: 0.6784, green: 0.9373, blue: 0.8196, alpha: 1), image: "cart"),
        Category(name: "Personal", textColor: UIColor(red: 0.3725, green: 0.2941, blue: 0.5451, alpha: 1), backgroundColor: UIColor(red: 0.902, green: 0.6039, blue: 0.5529, alpha: 1), image: "person")
    ]
}

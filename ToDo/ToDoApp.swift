//
//  ToDoApp.swift
//  ToDo
//
//  Created by zari on 23/10/2021.
//

import SwiftUI

@main
struct ToDoApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(listViewModel)
        }
    }
}

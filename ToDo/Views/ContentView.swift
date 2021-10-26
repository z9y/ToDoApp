//
//  ContentView.swift
//  ToDo
//
//  Created by zari on 23/10/2021.
//

import SwiftUI
import AlertToast

struct ContentView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        NavigationView {
            VStack {     
                if listViewModel.items.isEmpty {
                    NoItemsView()
                } else {
                    ListView()
                }
            }
            .toast(isPresenting: $listViewModel.showAddedToast) {
                AlertToast(type: .complete(.green), title: "Added")
            }
            .toast(isPresenting: $listViewModel.showDeleteToast) {
                AlertToast(type: .complete(.red), title: "Deleted")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ListViewModel())
    }
}

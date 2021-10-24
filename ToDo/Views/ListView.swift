//
//  ListView.swift
//  ToDo
//
//  Created by zari on 23/10/2021.
//

import SwiftUI
import AlertToast

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var showDeleteAlert = false
    @State private var indexSetToDelete: IndexSet?
    @State private var showDeleteToast = false
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        RowView(item: item)
                    }
                    .onDelete { (indexSet) in
                        self.showDeleteAlert = true
                        self.indexSetToDelete = indexSet
                    }
                    .onMove(perform: listViewModel.moveItem)
                }
                .alert(isPresented: $showDeleteAlert) {
                    deleteAlert()
                }
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink("Add", destination: AddView())
                    }
                }
            }
        }
        .navigationTitle("ToDo")
        .toast(isPresenting: $listViewModel.showToast) {
            AlertToast(type: .complete(.green), title: "Added")
        }
        .toast(isPresenting: $showDeleteToast) {
            AlertToast(type: .complete(.red), title: "Deleted")
        }
    }
    
    func deleteAlert() -> Alert {
        return Alert(title: Text("Are You sure ?"), primaryButton: .destructive(Text("Delete")) {
            listViewModel.deleteItem(indexSet: self.indexSetToDelete!)
            showDeleteToast.toggle()
        },
            secondaryButton: .cancel())
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}

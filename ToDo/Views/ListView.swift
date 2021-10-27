//
//  ListView.swift
//  ToDo
//
//  Created by zari on 23/10/2021.
//

import SwiftUI
//import AlertToast

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var showDeleteAlert = false
    @State private var indexSetToDelete: IndexSet?
    @State private var showActionSheet = false
    
    var body: some View {
        List {
            ForEach(listViewModel.items) { item in
                RowView(item: item)
                    .listRowBackground(Color.clear)
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
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Sort") {
                    showActionSheet = true
                }
            }
        }
        .foregroundColor(.primary)
        .confirmationDialog("Sort by: ", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("Date") {
                listViewModel.sortByDate()
            }
            Button("Category") {
                listViewModel.sortByCategory()
            }
            Button("Priority") {
                listViewModel.sortByPriority()
            }
        }
    }
    
    //ALERT PRZY PRÓBIE USUNIĘCIA ELEMENTU
    func deleteAlert() -> Alert {
        return Alert(title: Text("Are You sure ?"), primaryButton: .destructive(Text("Delete")) {
            listViewModel.deleteItem(indexSet: self.indexSetToDelete!)
            listViewModel.showDeleteToast.toggle()
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

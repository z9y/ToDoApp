//
//  AddView.swift
//  ToDo
//
//  Created by zari on 23/10/2021.
//

import SwiftUI
import AlertToast

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var textFieldText: String = ""
    @State var prior: String = "Low"
    @State var datePicker = Date()
    @State var cat: Int = 0
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var showToast: Bool = false
    @FocusState private var isFocused: Bool
    
    var priority = ["Low", "Medium", "High"]
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                Button(action: {
                    saveButton()
                }, label: {
                    Text("Add")
                })
            }
            .padding()
            Text("Add new ToDo")
                .font(.title2)
            Form {
                Section {
                    TextField("Write something here...", text: $textFieldText)
                        .focused($isFocused)
                } header: {
                    Text("Name")
                }
            
                Section {
                    Picker("Select priority", selection: $prior, content: {
                        ForEach(priority, id: \.self) { text in
                            Text(text)
                        }
                    })
                        .pickerStyle(.segmented)
                } header: {
                    Text("Select priority")
                }
                
                Section {
                Picker("Select category", selection: $cat, content: {
                    ForEach(0..<listViewModel.categories.count, id: \.self) {
                        Text(listViewModel.categories[$0].name).tag($0)
                        }
                    })
                } header: {
                    Text("Select category")
                }
                
                Section {
                    DatePicker("Date", selection: $datePicker, in: Date()...)
                        //.datePickerStyle(.graphical)
                } header: {
                    Text("Select date and time")
                }
            }
            .navigationBarHidden(true)
            .alert(isPresented: $showAlert, content: getAlert)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Close") {
                        isFocused = false
                    }
                }
            }
        }
    }
    
    func saveButton() {
        if checkText() {
            listViewModel.addItem(text: textFieldText, priority: prior, category: cat, date: datePicker)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func checkText() -> Bool {
        if textFieldText.count < 4 {
            alertTitle = "The text must contain at least 4 characters."
            showAlert.toggle()
            return false
        }
        listViewModel.showToast.toggle()
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(ListViewModel())
    }
}

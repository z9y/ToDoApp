//
//  RowView.swift
//  ToDo
//
//  Created by zari on 23/10/2021.
//

import SwiftUI

struct RowView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State var checkDate: Bool = false
    @State var repeatBool: Bool = false
    
    let item: ItemModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    //FORMATOWANIE DATY
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.string(from: date)
    }

    //ZMIANA KOLORU PRIORYTETU
    func priorityChange() -> Color {
        switch item.priority {
        case "Low":
            return Color.green
        case "Medium":
            return Color.orange
        case "High":
            return Color.red
        default:
            return Color.black
        }
    }
    //SPRAWDZA CZY DATA WPROWADZONA PRZEZ UŻYTKOWNIKA JUŻ MINĘŁA
    func compareDate() {
        if Date() > item.date {
            checkDate = true
        }
    }
    
    var body: some View {
        let itemCategory = listViewModel.categories[item.category]
        
        HStack {
            Button(action: {
                listViewModel.changeCompletion(item: item)
            }, label: {
                Image(systemName: item.isCompleted ? "square.fill" : "square")
                    .foregroundColor(.black)
            })
            Image(systemName: itemCategory.image)
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(.black)
            Text(item.text)
                .font(.callout)
                .foregroundColor(Color(itemCategory.textColor))
                .strikethrough(item.isCompleted ? true : false)
            Spacer()
            VStack(alignment: .trailing) {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 7.0, height: 7.0)
                    .foregroundColor(priorityChange())
                Text("\(formatDate(date: item.date))")
                    .font(.caption2)
                    .foregroundColor(item.isCompleted ? .black : (checkDate ? (repeatBool ? .red : .black) : .black))
                    .strikethrough(item.isCompleted ? true : false)
                    .onReceive(timer) { _ in
                        compareDate()
                        if checkDate {
                            repeatBool.toggle()
                        }
                    }
            }
        }
        .font(.title3)
        .padding()
        .background(Color(itemCategory.backgroundColor))
        .cornerRadius(15)
    }
}

struct RowView_Previews: PreviewProvider {
    static var item1 = ItemModel(text: "This is the 1st model", priority: "Low", isCompleted: true, date: Date(), category: 1)
    static var item2 = ItemModel(text: "This is the 2nd model", priority: "Medium", isCompleted: false, date: Date(), category: 2)
    static var item3 = ItemModel(text: "This is the 3th model", priority: "High", isCompleted: true, date: Date(), category: 3)
    
    static var previews: some View {
        Group {
            RowView(item: item1)
            RowView(item: item2)
            RowView(item: item3)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(ListViewModel())
    }
}

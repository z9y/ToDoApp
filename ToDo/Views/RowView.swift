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

    //formatowanie daty
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.string(from: date)
    }

    //zmiana koloru priorytetu
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
    
    func compareDate() {
        if Date() > item.date {
            checkDate = true
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {
                listViewModel.changeCompletion(item: item)
            }, label: {
                Image(systemName: item.isCompleted ? "square.fill" : "square")
                    .foregroundColor(.primary)
            })
            Image(systemName: listViewModel.categories[item.category].image)
                .resizable()
                .frame(width: 18, height: 18)
            Text(item.text)
                .font(.callout)
                .foregroundColor(Color(listViewModel.categories[item.category].textColor))
                .strikethrough(item.isCompleted ? true : false)
            Spacer()
            VStack(alignment: .trailing) {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 7.0, height: 7.0)
                    .foregroundColor(priorityChange())
                Text("\(formatDate(date: item.date))")
                    .font(.caption2)
                    .fontWeight(item.isCompleted ? nil : (repeatBool ? .bold : .semibold))
                    .foregroundColor(item.isCompleted ? .primary : (checkDate ? .red : .primary))
                    .strikethrough(item.isCompleted ? true : false)
                    .animation(repeatBool ? .easeIn : nil)
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
        .background(Color(listViewModel.categories[item.category].backgroundColor))
        .cornerRadius(15)
    }
}

struct RowView_Previews: PreviewProvider {
    static var item1 = ItemModel(text: "This is the 1st model", priority: "Low", isCompleted: true, date: Date(), category: 1)
    static var item2 = ItemModel(text: "This is the 2st modelaaa", priority: "Medium", isCompleted: false, date: Date(), category: 2)
    static var item3 = ItemModel(text: "This is the 1st model", priority: "High", isCompleted: true, date: Date(), category: 3)
    
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

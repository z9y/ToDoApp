//
//  ContentView.swift
//  ToDo
//
//  Created by zari on 23/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ListViewModel())
    }
}

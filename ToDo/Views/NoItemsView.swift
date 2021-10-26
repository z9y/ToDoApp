//
//  NoItemsView.swift
//  ToDo
//
//  Created by zari on 24/10/2021.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var addAnimation: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no items !")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Click on the button below and add Your 1st ToDo !")
                    .padding(.bottom, 20)
                
                NavigationLink(destination: AddView(), label: {
                    Text("Add 1st ToDo!")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(addAnimation ? Color(red: 0, green: 0.1373, blue: 0.6118) : Color(red: 0.8824, green: 0.0235, blue: 0))
                        .cornerRadius(10)
                })
                    .padding(.horizontal, addAnimation ? 30 : 50)
                    .shadow(
                        color: addAnimation ? Color(red: 0, green: 0.1373, blue: 0.6118).opacity(0.5) : Color(red: 0.8824, green: 0.0235, blue: 0).opacity(0.5),
                        radius: addAnimation ? 30 : 10,
                        x: 0,
                        y: addAnimation ? 50 : 30)
                    .scaleEffect(addAnimation ? 1.1 : 1.0)
                    .offset(y: addAnimation ? -7 : 0)
            }
            .multilineTextAlignment(.center)
            .padding(30)
            .onAppear(perform: addButtonAnimation)
        }
    }
    
    //ANIMACJA PRZYCISKU
    func addButtonAnimation() {
        guard !addAnimation else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                addAnimation.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemsView()
    }
}

//
//  ContentView.swift
//  TicTacToe
//
//  Created by fyz on 12/8/22.
//

import SwiftUI

struct WelcomeView: View {
    @State var name:String = ""
    @State var isStarted:Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("startBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TextField("Name", text: $name)
                        .padding(.leading)
                        .frame(width: 380, height: 50)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                    Button {
                        if !name.isEmpty {
                            isStarted.toggle()
                        }
                    } label: {
                        Text("START")
                            .padding()
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color("startTextColor"))
                            .background(Color("startButtonColor").opacity(0.8))
                            .cornerRadius(10)
                    }
                }
            }
            .navigationDestination(isPresented: $isStarted) {
                GameView(name: name)
            }
        }
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

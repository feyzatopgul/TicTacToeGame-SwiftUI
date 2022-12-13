//
//  GameView.swift
//  TicTacToe
//
//  Created by fyz on 12/8/22.
//

import SwiftUI

struct GameView: View {
    @StateObject var game = Game()
    @State var isEnded:Bool = false
    @State var isBoardDisabled:Bool = false
    
    var body: some View {
        ZStack {
            Image("gameBackground")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                GeometryReader { geo in
                    VStack {
                        ForEach(0..<3) { i in
                            HStack {
                                ForEach(0..<3) { j in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.white.opacity(0.5))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(lineWidth: 5)
                                            }
                                        Text(game.board[3 * i + j])
                                            .font(.system(size: 70))
                                    }
                                    .padding(3)
                                    .shadow(radius: 50)
                                    .frame(width: geo.size.width/3, height: geo.size.width/3)
                                    .onTapGesture {
                                        withAnimation {
                                            if !game.availableMoves.contains(3 * i + j) {
                                                return
                                            }
                                            game.humanMove(index: 3 * i + j)
                                            //isBoardDisabled = true
                                            if game.isWinned(currentBoard: game.board, player: .human) || game.isTied() {
                                                isEnded = true
                                            }
                                            else {
                                                //DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                    game.aiMove()
                                                    if game.isWinned(currentBoard: game.board, player: .ai) || game.isTied() {
                                                        isEnded = true
                                                    }
                                                    //isBoardDisabled = false
                                                //}
                                            }
                                        }
                                    }
                                    .alert(alertText(), isPresented: $isEnded) {
                                        Button("OK", role: .cancel) {
                                            game.reset()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                //.disabled(isBoardDisabled)
                .padding(.top, 150)
                .padding(.leading, 20)
                .padding(.trailing, 30)
                Button {
                    game.reset()
                } label: {
                    Text("Reset")
                        .foregroundColor(.black)
                        .font(.system(size: 30, weight:.bold, design: .rounded))
                }
                .padding(.bottom, 50)
            }
        }
    }
    func alertText() -> String {
        if game.winner == .human {
            return "🥳 You won 🥳"
        }
        else if game.winner == .ai {
            return "😢 You lost 😢"
        } else {
            return "Game over 😐"
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

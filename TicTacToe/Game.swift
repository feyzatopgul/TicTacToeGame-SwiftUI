//
//  File.swift
//  TicTacToe
//
//  Created by fyz on 12/8/22.
//

import Foundation

class Game: ObservableObject {
    
    @Published var board:[String] = ["", "", "", "", "", "", "", "", ""]
    @Published var winner: Player? = nil
    @Published var availableMoves: Set<Int> = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    
    
    func humanMove(index: Int) {
        if availableMoves.contains(index) {
            board[index] = "X"
            availableMoves.remove(index)
        }
    }
    
    func randomMove() {
        if let randomMove = availableMoves.randomElement() {
            board[randomMove] = "O"
            availableMoves.remove(randomMove)
        }
    }
    
    func aiMove() {
        var tempBoard = board
        var bestMove = -1
        var bestScore = 0
        
        func minimax(isMax: Bool) -> Int {
            var scores:[Int] = []
            var moves:[Int] = []
        
            if isWinned(currentBoard:tempBoard, player: .human) {
                return -1 * (availableMoves.count + 1)
            }
            if isWinned(currentBoard:tempBoard, player: .ai) {
                return 1 * (availableMoves.count + 1)
            }
            if availableMoves.isEmpty {
                return 0
            }
            for i in 0...8 {
                if tempBoard[i] == "" {
                    tempBoard[i] = isMax ? "O" : "X"
                    availableMoves.remove(i)
                    let score = minimax(isMax: !isMax)
                    scores.append(score)
                    moves.append(i)
                    tempBoard[i] = ""
                    availableMoves.insert(i)
                }
            }
            if isMax {
                bestScore = Int.min
                for i in 0...scores.count - 1 {
                    if scores[i] > bestScore {
                        bestScore = scores[i]
                        bestMove = moves[i]
                    }
                }
            } else {
                bestScore = Int.max
                for i in 0...moves.count - 1 {
                    if scores[i] < bestScore {
                        bestScore = scores[i]
                        bestMove = moves[i]
                    }
                }
            }
            return bestScore
        }

        _ = minimax(isMax: true)
        board[bestMove] = "O"
        availableMoves.remove(bestMove)
    }
    
    func isWinned(currentBoard: [String], player: Player) -> Bool {
        if currentBoard[0] == player.rawValue && currentBoard[1] == player.rawValue && currentBoard[2] == player.rawValue ||
            currentBoard[3] == player.rawValue && currentBoard[4] == player.rawValue && currentBoard[5] == player.rawValue ||
            currentBoard[6] == player.rawValue && currentBoard[7] == player.rawValue && currentBoard[8] == player.rawValue ||
            currentBoard[0] == player.rawValue && currentBoard[3] == player.rawValue && currentBoard[6] == player.rawValue ||
            currentBoard[1] == player.rawValue && currentBoard[4] == player.rawValue && currentBoard[7] == player.rawValue ||
            currentBoard[2] == player.rawValue && currentBoard[5] == player.rawValue && currentBoard[8] == player.rawValue ||
            currentBoard[0] == player.rawValue && currentBoard[4] == player.rawValue && currentBoard[8] == player.rawValue ||
            currentBoard[2] == player.rawValue && currentBoard[4] == player.rawValue && currentBoard[6] == player.rawValue {
            winner = player
            return true
        }
        else {
            return false
        }
    }
    
    func isTied() -> Bool {
        if availableMoves.isEmpty {
            winner = nil
            return true
        } else {
            return false
        }
    }
    
    func reset() {
        board = ["", "", "", "", "", "", "", "", ""]
        availableMoves = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    }
}

enum Player:String {
    case human = "X"
    case ai = "O"
}


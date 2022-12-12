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
                
            func minMax(isMax: Bool) -> Int {
                
                if isWinned(currentBoard:tempBoard, player: .human) {
                    return -1 * (availableMoves.count + 1)
                }
                if isWinned(currentBoard:tempBoard, player: .ai) {
                    return 1 * (availableMoves.count + 1)
                }
                if availableMoves.isEmpty {
                    return 0
                }
                if isMax {
                    var best = Int.min
                    for i in 0...8 {
                        if tempBoard[i] == "" {
                            tempBoard[i] = "O"
                            availableMoves.remove(i)
                            best = max(best, minMax(isMax: !isMax))
                            tempBoard[i] = ""
                            availableMoves.insert(i)
                        }
                    }
                    return best
                } else {
                    var best = Int.max
                    for i in 0...8 {
                        if tempBoard[i] == "" {
                            tempBoard[i] = "X"
                            availableMoves.remove(i)
                            best = min(best, minMax(isMax: !isMax))
                            tempBoard[i] = ""
                            availableMoves.insert(i)
                        }
                    }
                    return best
                }
            }
            
            func findBestMove() -> Int {
                var bestScore = Int.min
                var bestMove = -1
                
                for i in 0...8 {
                    if tempBoard[i] == "" {
                        tempBoard[i] = "O"
                        let moveScore = minMax(isMax: false)
                        tempBoard[i] = ""
                        if moveScore > bestScore {
                            bestMove = i
                            bestScore = moveScore
                        }
                    }
                }
                return bestMove
            }
            let bestMove = findBestMove()
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


//
//  GameViewModel.swift
//  Pippo
//
//  Created by Apple  on 10/04/2022.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    
    let columns: [GridItem] = [GridItem(.flexible(), spacing: -20),
                               GridItem(.flexible(), spacing: -20),
                               GridItem(.flexible(), spacing: -20)]
    
    func textIsAproppiate(name1: String, name2: String) -> Bool {
        if (name1.isEmpty || name1.count < 3) || (name2.isEmpty || name2.count < 3) {
            return false
        }
        return true
    }
    
    func nameForPlayer(player: String) -> String {
        return "¡\(player) debe comenzar el juego!"
    }
    
    func isOcuppied(index: Int) -> Bool {
        
        let filteredMoves = moves.firstIndex { $0?.boardIndex == index }
        return filteredMoves == nil
        
    }
    
    func gameEnded() -> Bool {
        let filteredArray = moves.filter { $0 == nil }
        return filteredArray.isEmpty
    }
    
    func isThereAWin(player: Player, moves: [Move?]) -> Bool {
        
        let winPositions: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPositions where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
    
}

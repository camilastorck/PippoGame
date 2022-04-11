//
//  GameModel.swift
//  Pippo
//
//  Created by Apple  on 09/04/2022.
//

import Foundation
import SwiftUI

struct Move {
    let boardIndex: Int
    var player: Player
    
    var background: Color {
        
        switch player {
        case .playerOne:
            return Palette.playerOneBg
        case .playerTwo:
            return Palette.playerTwoBg
        }
    }
    
    var indicator: String {
        
        switch player {
        case .playerOne:
            return "gorila"
        case .playerTwo:
            return "leopard"
        }
    }
}

enum Player {
    case playerOne, playerTwo
}

enum Animals {
    case cat, dog, rabbit, cow, horse, monkey
}

//enum Fruits {
//    case orange, banana, apple, grapes, strawberry, kiwi
//}

//enum Numbers {
//    case one, two, three, four, five, six
//}

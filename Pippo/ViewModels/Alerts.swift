//
//  Alerts.swift
//  Pippo
//
//  Created by Apple  on 10/04/2022.
//

import Foundation

struct AlertItem: Identifiable {
    let id = UUID().uuidString
    let title: String
    let message: String
    let buttonTitle: String
}

struct AlertContext {
    
    static let playerOneWin = AlertItem(title: "El jugador 1 gana, ¡Felicidades!",
                                    message: "¿Iniciar una nueva partida?",
                                    buttonTitle: "Ok")
    
    static let playerTwoWin = AlertItem(title: "El jugador 2 gana, ¡Felicidades!",
                                    message: "¿Iniciar una nueva partida?",
                                    buttonTitle: "Ok")
    
    static let gameIsOver = AlertItem(title: "¡Es un empate! El juego ha terminado",
                                    message: "¿Iniciar una nueva partida?",
                                    buttonTitle: "Ok")
    
    static let namesArentAproppiate = AlertItem(title: "Los nombres deben tener al menos 3 caracteres", message: "Intenta otra vez", buttonTitle: "Ok")
}

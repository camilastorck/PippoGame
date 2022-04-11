//
//  GameView.swift
//  Pippo
//
//  Created by Apple  on 10/04/2022.
//
// 

import SwiftUI

struct GameView: View {
    
    @StateObject var vm: GameViewModel = GameViewModel()
    @State var alerts: AlertItem?
    @State var currentPlayer = "Jugador 1, ¡es tu turno!"
    @State var playerOneTurn = true
    @State var playerTwoTurn = false
    @State var disable = false
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
            VStack {
                Text(currentPlayer)
                    .font(Font.custom("FredokaOne-Regular", size: 32))
                    .multilineTextAlignment(.center)
                    
                Text("Selecciona un casillero.")
                    .font(Font.custom("Jost", size: 17))
                    .padding(10)
                LazyVGrid(columns: vm.columns, spacing: 15) {
                    ForEach(0..<9, id: \.self) { i in
                        ZStack {
                            Rectangle()
                                .foregroundColor(vm.moves[i]?.background ?? Palette.mainColor)
                                .cornerRadius(10)
                            Image(vm.moves[i]?.indicator ?? "empty")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                        }
                        .frame(width: 85, height: 85)
                        .onTapGesture {
                            
                            // Player One
                            if playerOneTurn && vm.isOcuppied(index: i) {
                                vm.moves[i] = Move(boardIndex: i, player: .playerOne)
                                disable = true
                                playerOneTurn = false
                                playerTwoTurn = true
                                currentPlayer = "Jugador 2, ¡Es tu turno!"
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                                    disable = false
                                }
                                
                                if vm.gameEnded() {
                                    alerts = AlertContext.gameIsOver
                                }
                                
                                if vm.isThereAWin(player: .playerOne, moves: vm.moves) {
                                    disable = true
                                    alerts = AlertContext.playerOneWin
                                }
                                
                                return
                            }
                        
                            // Player Two
                            if playerTwoTurn && vm.isOcuppied(index: i) {
                                vm.moves[i] = Move(boardIndex: i, player: .playerTwo)
                                disable = true
                                playerTwoTurn = false
                                playerOneTurn = true
                                currentPlayer = "¡Es turno del jugador 1!"
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                                    disable = false
                                }

                                if vm.gameEnded() {
                                    alerts = AlertContext.gameIsOver
                                }
                                
                                if vm.isThereAWin(player: .playerTwo, moves: vm.moves) {
                                    disable = true
                                    alerts = AlertContext.playerTwoWin
                                }
                                
                                return
                                
                            }
                        }
                    }
                }
                .disabled(disable)
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.7, alignment: .center)
            .padding(.horizontal, 20)
            .background(Palette.lightAccent)
            .cornerRadius(20)
            
            .alert(item: $alerts) { alert in
                Alert(title: Text(alert.title),
                      message: Text(alert.message),
                      dismissButton: .default(Text(alert.buttonTitle)) {
                    vm.resetGame()
                    currentPlayer = "Jugador 1, ¡es tu turno!"
                    playerTwoTurn = false
                    playerOneTurn = true
                    disable = false
                }
                )
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

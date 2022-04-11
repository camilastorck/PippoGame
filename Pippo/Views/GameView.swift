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
    @State var playerOne: String
    @State var playerTwo: String
    @State var alerts: AlertItem?
    @State var currentPlayer = "¡Que empiece el juego!"
    @State var playerOneTurn = true
    @State var playerTwoTurn = false
    @State var disable = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                
            VStack {
                Text(currentPlayer)
                    .font(Font.custom("FredokaOne-Regular", size: 32))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Text(vm.nameForPlayer(player: playerOne))
                    .font(Font.custom("Jost", size: 19))
                    .padding(5)
                    .multilineTextAlignment(.center)
                Text("Selecciona un casillero.")
                    .font(Font.custom("Jost", size: 17))
                    .padding(.horizontal, 10)
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
                                currentPlayer = "\(playerTwo), ¡Es tu turno!"
                                
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
                                currentPlayer = "\(playerOne), ¡Es tu turno!"
                                
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
                
                Button("Ingresar nuevos jugadores") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .frame(width: UIScreen.main.bounds.width * 0.6)
                .padding(10)
                .foregroundColor(Palette.darkAccent)
                .font(Font.custom("Jost", size: 18))
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
                    currentPlayer = "¡Que empiece el juego!"
                    playerTwoTurn = false
                    playerOneTurn = true
                    disable = false
                }
                )
            }
        }
        .navigationBarHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(playerOne: "", playerTwo: "")
    }
}

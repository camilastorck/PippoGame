//
//  WelcomeView.swift
//  Pippo
//
//  Created by Apple  on 11/04/2022.
//

import SwiftUI

struct WelcomeView: View {
    
    @StateObject var vm = GameViewModel()
    @State var alerts: AlertItem?
    @State var playerOneName = ""
    @State var playerTwoName = ""
    @State var action: Int? = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Bienvenidos a Pippo!")
                        .font(Font.custom("FredokaOne-Regular", size: 40))
                        .multilineTextAlignment(.center)
                    Text("Ingrese el nombre de los jugadores.")
                        .font(Font.custom("Jost", size: 20))
                        .padding(.horizontal, 10)
                        .multilineTextAlignment(.center)
                    TextField("Nombre del primer jugador", text: $playerOneName)
                        .frame(width: UIScreen.main.bounds.width * 0.6)
                        .padding(15)
                        .background(.white)
                        .cornerRadius(10)
                        .font(Font.custom("Jost", size: 15))
                    TextField("Nombre del segundo jugador", text: $playerTwoName)
                        .frame(width: UIScreen.main.bounds.width * 0.6)
                        .padding(15)
                        .background(.white)
                        .cornerRadius(10)
                        .font(Font.custom("Jost", size: 15))
                    
                    NavigationLink("", destination: GameView(playerOne: playerOneName, playerTwo: playerTwoName), tag: 1, selection: $action)
                    
                    Button("Empezar", action: {
                        if vm.textIsAproppiate(name1: playerOneName, name2: playerTwoName) {
                            action = 1
                        } else {
                            alerts = AlertContext.namesArentAproppiate
                        }}
                        )
                        .frame(width: UIScreen.main.bounds.width * 0.3)
                        .padding(8)
                        .background(Palette.darkAccent)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .font(Font.custom("Jost", size: 18))
      
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6, alignment: .center)
                .padding(.horizontal, 20)
                .background(Palette.lightAccent)
                .cornerRadius(20)
                .padding(.bottom, 80)
                
                .alert(item: $alerts) { alert in
                    Alert(title: Text(alert.title),
                          message: Text(alert.message),
                          dismissButton: .cancel(Text(alert.buttonTitle)) { }
                    )
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WelcomeView()
        }
    }
}

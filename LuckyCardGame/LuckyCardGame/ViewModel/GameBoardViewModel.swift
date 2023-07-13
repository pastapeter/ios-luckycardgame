//
//  GameBoardViewModel.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/9/23.
//

import Foundation

enum GameBoardViewModelError: LocalizedError {
  
}

final class GameBoardViewModel {
  
  private var game: Game

  var didStartGame: ((Game) -> Void)?
  var didChangeNumberOfPlayer: ((Game) -> Void)?
  var clearGame: (() -> Void)?
  
  var numberOfPlayers: Int {
    return game.players.count
  }
  
  var gameType: [NumberOfPlayer] {
    return NumberOfPlayer.allCases
  }
  
  init(game: Game) {
    self.game = game
  }
  

  func changeNumberOfPlayer(by numberOfPlayer: NumberOfPlayer) {
    
    game = LuckyCardGame(numberOfPlayer: numberOfPlayer)
    game.startGame()
    clearGame?()
    didChangeNumberOfPlayer?(game)
  }
  
  func startGame() {
    game.startGame()
    didStartGame?(game)
  }
  
}

extension GameBoardViewModel {
  
}



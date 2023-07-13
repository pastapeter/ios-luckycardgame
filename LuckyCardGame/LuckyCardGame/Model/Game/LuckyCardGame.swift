//
//  LuckyCardGame.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/7/23.
//

import Foundation

enum GameError: Error {
  case invalidNumberofPlayer
}

protocol Game {
  var players: [LuckyCardGamePlayer] { get }
  var field: LuckyGameField { get }
  func startGame()
}

class LuckyCardGame: Game {
  
  private(set) var players: [LuckyCardGamePlayer]
  private(set) var field: LuckyGameField
  private var dealer: LuckyCardDealer
  private var gameStrategy: GameStrategy
  
  init(players: [LuckyCardGamePlayer], dealer: LuckyCardDealer, gameStrategy: GameStrategy) {
    self.players = players
    self.dealer = dealer
    self.gameStrategy = gameStrategy
    self.field = LuckyGameField()
  }
  
}

// MARK: - convenience Init

extension LuckyCardGame {
  
  convenience init(numberOfPlayer: NumberOfPlayer) {
    let players = (0..<numberOfPlayer.rawValue).enumerated().map { LuckyCardGamePlayer(id: PlayerDataBase.currentPlayerName[$1])
    }
    let strategy = numberOfPlayer.strategy
    let dealer = LuckyCardDealer(deck: LuckyCardDeck(), strategy: strategy)
    self.init(players: players, dealer: dealer, gameStrategy: strategy)
  }
  
  convenience init(players: [LuckyCardGamePlayer]) throws {
    guard let strategy = NumberOfPlayer(rawValue: players.count)?.strategy else {
      throw GameError.invalidNumberofPlayer
    }
    let dealer = LuckyCardDealer(deck: LuckyCardDeck(), strategy: strategy)
    self.init(players: players, dealer: dealer, gameStrategy: strategy)
  }
  
}

// MARK: - Game Extension

extension LuckyCardGame {
  
  func startGame() {
    dealer.gameStart(with: players, on: field)
  }
  
}

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

protocol Game: AnyObject {
  func startGame()
}

class LuckyCardGame: Game {
  
  private var players: [LuckyCardGamePlayer]
  private var field: LuckyGameField
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
    let players = (0..<numberOfPlayer.rawValue).map { _ in LuckyCardGamePlayer() }
    let strategy = numberOfPlayer.strategy
    let dealer = LuckyCardDealer(deck: LuckyCardDeck.make(), strategy: strategy)
    self.init(players: players, dealer: dealer, gameStrategy: strategy)
  }
  
  convenience init(players: [LuckyCardGamePlayer]) throws {
    guard let strategy = NumberOfPlayer(rawValue: players.count)?.strategy else {
      throw GameError.invalidNumberofPlayer
    }
    let dealer = LuckyCardDealer(deck: LuckyCardDeck.make(), strategy: strategy)
    self.init(players: players, dealer: dealer, gameStrategy: strategy)
  }
  
}

// MARK: - Game Extension

extension LuckyCardGame {
  
  func startGame() {
    dealer.gameStart(with: players, on: field)
  }
  
}

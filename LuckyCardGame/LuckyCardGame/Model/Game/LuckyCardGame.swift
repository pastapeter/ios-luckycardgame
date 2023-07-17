//
//  LuckyCardGame.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/7/23.
//

import Foundation

class LuckyCardGame: Game, GameProceedDelegate {
  
  private var players: [CardgamePlayerable]
  private var field: CardGameBoardComponent
  private var dealer: LuckyCardDealerProtocol
  private(set) var gameStrategy: GameStrategy
  
  init(players: [CardgamePlayerable], dealer: LuckyCardDealerProtocol, gameStrategy: GameStrategy, field: CardGameBoardComponent) {
    self.players = players
    self.dealer = dealer
    self.gameStrategy = gameStrategy
    self.field = field
  }
  
}

// MARK: - convenience Init

extension LuckyCardGame {
  
  convenience init(numberOfPlayer: NumberOfPlayer) {
    let players = (0..<numberOfPlayer.rawValue).enumerated().map { LuckyCardGamePlayer(id: PlayerDataBase.currentPlayerName[$1])
    }
    let strategy = numberOfPlayer.strategy
    let dealer = LuckyCardDealer(deck: LuckyCardDeck(), gameProceedDelegate: nil)
    self.init(players: players, dealer: dealer, gameStrategy: strategy, field: LuckyGameField())
    dealer.setDelegateForProceedGame(with: self)
  }
  
  convenience init(players: [CardgamePlayerable]) throws {
    guard let strategy = NumberOfPlayer(rawValue: players.count)?.strategy else {
      throw GameError.invalidNumberofPlayer
    }
    let dealer = LuckyCardDealer(deck: LuckyCardDeck(), gameProceedDelegate: nil)
    self.init(players: players, dealer: dealer, gameStrategy: strategy, field: LuckyGameField())
    dealer.setDelegateForProceedGame(with: self)
  }
  
}

// MARK: - Game Extension

extension LuckyCardGame {
  
  func startGame() {
    dealer.gameStart(with: players, on: field as! LuckyGameField)
  }
  
  func playerCards() -> [[LuckyCard]] {
    return players.map { $0.cards }
  }
  
  func fieldCards() -> [LuckyCard] {
    return field.cards
  }
  
  func numberOfPlayer() -> Int {
    return players.count
  }
  
  func checkStatusForNextTurn(with targetPlayerId: String, cardIndex: Int) throws -> Bool {
    return try dealer.checkCards(with: targetPlayerId, fieldCardIndex: cardIndex)
  }
  
  func sort(playerId: String) {
    guard let player = getPlayer(whose: playerId) else { return }
    player.sort(ascending: true)
  }
  
  func sortCardInField() {
    field.sort(ascending: true)
  }
  
}

// MARK: - GameDealerDelegate Extension
extension LuckyCardGame {
  
  func getPlayer(whose id: String) -> CardgamePlayerable? {
    return players.first { $0.id == id }
  }
  
  func getCurrentPlayer() -> CardgamePlayerable? {
    return players.first { $0.isCurrentPlayer() }
  }
  
  func getCardFromField(in index: Int) -> LuckyCard? {
    return field.getCardFromDeck(in: index)
  }
  
}

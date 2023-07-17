//
//  MockDealer.swift
//  LuckyCardGameTests
//
//  Created by Jung peter on 7/17/23.
//

import Foundation
@testable import LuckyCardGame

final class MockDealer: LuckyCardDealerProtocol {
  
  func gameStart(with players: [CardgamePlayerable], on field: CardGameBoardComponent) {
    
    zip(players, cardCollection).forEach { player, cards in
      for card in cards {
        player.receiveCard(card)
      }
    }
    
    for card in fieldCards {
      self.field.receiveCard(card)
    }
    
  }
  
  func checkCards(with targetPlayerId: String, fieldCardIndex: Int) throws -> Bool {
    
    guard let targetPlayer = players.first(where: {$0.id == targetPlayerId }) else {
      throw GameProceedingError.noTargetPlayerInThisGame
    }
    
    if fieldCardIndex >= field.cards.count {
      throw GameProceedingError.GameSystemError
    }
    
    guard let delegate = delegate else { throw GameProceedingError.GameSystemError }
    
    guard let currentPlayer = players.first(where: { $0.isCurrentPlayer() }) else {
      throw GameProceedingError.noCurrentPlayerInThisGame
    }
    
    return try delegate.gameStrategy.checkForNextTurnAlgorithm(player1: currentPlayer, player2: targetPlayer, cardFromField: field.cards[fieldCardIndex])
    
  }
  
  func setDelegateForProceedGame(with delegate: GameProceedDelegate) {
    self.delegate = delegate
  }
  
  func receiveCard(_ card: LuckyCard) {
    return
  }
  
  private var deck: LuckyCardDeck = .init(cards: [])
  private weak var delegate: GameProceedDelegate?
  var players: [CardgamePlayerable] = []
  var cardCollection: [[LuckyCard]]
  var field: CardGameBoardComponent
  var fieldCards: [LuckyCard]
  
  init(playerCards: [[LuckyCard]], fieldCards: [LuckyCard]) {
    self.cardCollection = playerCards
    self.field = LuckyGameField(deck: LuckyCardDeck(cards: []))
    self.fieldCards = fieldCards
    for i in playerCards.indices {
      players.append(LuckyCardGamePlayer(deck: LuckyCardDeck(cards: []), id: PlayerDataBase.currentPlayerName[i]))
    }
  }
  
}

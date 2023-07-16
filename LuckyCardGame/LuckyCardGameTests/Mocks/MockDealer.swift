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
    
    for card in currentPlayerCards {
      currentPlayer.receiveCard(card)
    }
    
    for card in targetPlayerCards {
      targetPlayer.receiveCard(card)
    }
    
    for card in fieldCards {
      self.field.receiveCard(card)
    }
    
  }
  
  func checkCards(with targetPlayerId: String, fieldCardIndex: Int) throws -> Bool {
    if targetPlayerId != targetPlayer.id { throw GameProceedingError.noTargetPlayerInThisGame }
    if fieldCardIndex >= field.cards.count { throw GameProceedingError.GameSystemError}
    guard let delegate = delegate else { throw GameProceedingError.GameSystemError }
    
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
  var currentPlayer: CardgamePlayerable
  var targetPlayer: CardgamePlayerable
  var field: CardGameBoardComponent
  var currentPlayerCards: [LuckyCard]
  var targetPlayerCards: [LuckyCard]
  var fieldCards: [LuckyCard]
  
  init(currentPlayerCards: [LuckyCard], targetPlayerCards: [LuckyCard], fieldCards: [LuckyCard]) {
    self.currentPlayer = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: []), id: currentUserName)
    self.targetPlayer = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: []), id: "D")
    self.field = LuckyGameField(deck: LuckyCardDeck(cards: []))
    self.currentPlayerCards = currentPlayerCards
    self.targetPlayerCards = targetPlayerCards
    self.fieldCards = fieldCards
  }
  
}

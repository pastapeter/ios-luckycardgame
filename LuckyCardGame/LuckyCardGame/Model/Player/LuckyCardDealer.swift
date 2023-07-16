//
//  Dealer.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/6/23.
//


import Foundation

final class LuckyCardDealer: LuckyCardDealerProtocol, CardAccessible {

  typealias CardDeck = LuckyCardDeck
  private var deck: CardDeck
  private weak var gameProceedDelegate: GameProceedDelegate?
  
  init(deck: CardDeck, gameProceedDelegate: GameProceedDelegate?) {
    self.deck = deck
    self.gameProceedDelegate = gameProceedDelegate
  }
  
  func setDelegateForProceedGame(with delegate: GameProceedDelegate) {
    self.gameProceedDelegate = delegate
  }

  func gameStart(with players: [CardgamePlayerable], on field: CardGameBoardComponent) {
    
    //TODO: 회수하기
    guard let instruction = gameProceedDelegate?.gameStrategy.gameStartAlgorithm(deck) else { return }
    
    for i in players.indices {
      splitCard(to: players[i], cards: instruction.cardsSplited[i].cards)
    }
    splitCard(to: field, cards: instruction.cardsOnField)
  }
  
  var cards: [LuckyCard] {
    return deck.cards
  }
  
  func receiveCard(_ card: LuckyCard) {
    do { try deck.add(card: card) }
    catch { return }
  }
  
  func checkCards(with targetPlayerId: String, fieldCardIndex: Int) throws -> Bool {
    
    guard let delegate = gameProceedDelegate else { throw GameProceedingError.GameSystemError}
    
    guard let currentPlayer = delegate.getCurrentPlayer()
    else {
      throw GameProceedingError.noCurrentPlayerInThisGame
    }
    
    guard let counterpartPlayer = delegate.getPlayer(whose: targetPlayerId) else {
      throw GameProceedingError.noTargetPlayerInThisGame
    }
    
    
    guard let cardFromField = delegate.getCardFromField(in: fieldCardIndex) else { throw GameProceedingError.GameSystemError }
    
    return try delegate.gameStrategy.checkForNextTurnAlgorithm(player1: currentPlayer, player2: counterpartPlayer, cardFromField: cardFromField)
    
  }
  
}

// MARK: - Private methods
extension LuckyCardDealer {
  
  private func draw() throws -> LuckyCard {
    return try deck.removeLastCard()
  }
  
}

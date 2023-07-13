//
//  Dealer.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/6/23.
//


import Foundation

final class LuckyCardDealer: CardgameDealable, CardReceivable {
  typealias CardDeck = LuckyCardDeck
  private(set) var deck: LuckyCardDeck
  private var gameStrategy: GameStrategy
  
  init(deck: LuckyCardDeck, strategy: GameStrategy) {
    self.deck = deck
    self.gameStrategy = strategy
  }
  
  func gameStart(with players: [LuckyCardGamePlayer], on field: LuckyGameField) {
    let instruction = gameStrategy.gameStartAlgorithm(deck)
    for i in players.indices {
      splitCard(to: players[i], cards: instruction.cardsSplited[i].cards)
    }
    splitCard(to: field, cards: instruction.cardsOnField)
  }
  
  func receiveCard(_ card: CardDeck.DeckCard) {
    do { try deck.add(card: card) }
    catch (let e) { print(e.localizedDescription) }
  }
  
  private func draw() throws -> LuckyCard {
    return try deck.removeLastCard()
  }
  
}

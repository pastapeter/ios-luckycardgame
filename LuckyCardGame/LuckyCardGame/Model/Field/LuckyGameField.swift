//
//  LuckyGameField.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/10/23.
//

import Foundation

class LuckyGameField: CardGameBoardComponent {
  
  var deck: Deck
  init(deck: Deck) {
    self.deck = deck
  }
  
  func countCardsInDeck() -> Int {
    return deck.count()
  }
  
  var cards: [LuckyCard] {
    return deck.cards
  }
  
  func getCardFromDeck(in index: Int) -> LuckyCard? {
    if deck.count() <= index { return nil }
    return deck.cards[index]
  }
  
  func sort(ascending: Bool) {
    return deck.sort(ascending: ascending)
  }
  
  func max() -> LuckyCard? {
    return deck.maxByValue()
  }
  
  func min() -> LuckyCard? {
    return deck.minByValue()
  }
  
  func maxCardsOfDeck() -> [LuckyCard] {
    return deck.maxCards()
  }
  
  func minCardsOfDeck() -> [LuckyCard] {
    return deck.minCards()
  }

  
  func receiveCard(_ card: LuckyCard) {
    do { try deck.add(card: card) }
    catch (let e) {
      print(e.localizedDescription) }
  }
  
  convenience init() {
    self.init(deck: LuckyCardDeck(cards: []))
  }
}

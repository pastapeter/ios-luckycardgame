//
//  LuckyGameField.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/10/23.
//

import Foundation

class LuckyGameField: CardReceivable {
  
  typealias CardDeck = LuckyCardDeck
  var deck: CardDeck
  
  init(deck: CardDeck) {
    self.deck = deck
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

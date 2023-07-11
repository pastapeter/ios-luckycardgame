//
//  Player.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/6/23.
//

import Foundation

class LuckyCardGamePlayer: CardgamePlayerable {
  typealias CardDeck = LuckyCardDeck
  var id: String
  var deck: CardDeck
  
  init(deck: CardDeck, id: String) {
    self.deck = deck
    self.id = id
  }
  
  convenience init(id: String) {
    self.init(deck: LuckyCardDeck.make(cards: []), id: id)
  }
}

//
//  Player.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/6/23.
//

import Foundation

class LuckyCardGamePlayer: CardgamePlayerable {
  typealias CardDeck = LuckyCardDeck
  var deck: CardDeck
  
  init(deck: CardDeck) {
    self.deck = deck
  }
  
  convenience init() {
    self.init(deck: LuckyCardDeck.make())
  }
}

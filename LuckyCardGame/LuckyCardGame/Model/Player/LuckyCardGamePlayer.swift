//
//  Player.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/6/23.
//

import Foundation

class LuckyCardGamePlayer: CardgamePlayerable, Equatable {  
  
  static func == (lhs: LuckyCardGamePlayer, rhs: LuckyCardGamePlayer) -> Bool {
    return lhs.id == rhs.id
  }

  private(set) var id: String
  private var deck: Deck
  
  init(deck: Deck, id: String) {
    self.deck = deck
    self.id = id
  }
  
  var cards: [LuckyCard] {
    return deck.cards
  }
  
  func getCardFromDeck(in index: Int) -> LuckyCard? {
    if deck.count() >= index { return nil }
    return deck.cards[index]
  }
  
  func receiveCard(_ card: LuckyCard) {
    
    if self.id == currentUserName {
      card.flip()
    }
    
    do {
      try deck.add(card: card)
    } catch (let e) {
      print(e.localizedDescription)
    }
  }
  
  func maxCardsOfDeck() -> [LuckyCard] {
    return deck.maxCards()
  }
  
  func minCardsOfDeck() -> [LuckyCard] {
    return deck.minCards()
  }
  
  func max() -> LuckyCard? {
    return deck.maxByValue()
  }
  
  func min() -> LuckyCard? {
    return deck.minByValue()
  }
  
  func isCurrentPlayer() -> Bool {
    return self.id == currentUserName
  }
  
  func countCardsInDeck() -> Int {
    return deck.count()
  }
  
  func drawCard() throws -> LuckyCard {
    return try deck.removeLastCard()
  }
  
  func sort(ascending: Bool) {
    self.deck.sort(ascending: ascending)
  }
  
  func isCardTriple() -> Bool {
    var dictionary = [CardValue:Int]()
    for value in CardValue.allCases {
      dictionary.updateValue(0, forKey: value)
    }
    for card in deck.cards {
      dictionary[card.value]! += 1
    }
    return dictionary.filter { $0.value == 3 }.count > 0
  }
  
  convenience init(id: String) {
    self.init(deck: LuckyCardDeck(cards: []), id: id)
  }
}

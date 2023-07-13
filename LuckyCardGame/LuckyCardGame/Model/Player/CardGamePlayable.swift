//
//  CardGamePlayable.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/7/23.
//

import Foundation

protocol CardgamePlayerable: AnyObject, CardReceivable {
  var deck: CardDeck { get set }
  var id: String { get }
  func drawCard() throws -> CardDeck.DeckCard
}

extension CardgamePlayerable {
  
  func receiveCard(_ card: CardDeck.DeckCard) {
    
    if self.id == currentUserName {
      card.status = .up
    }
    
    do {
      try deck.add(card: card)
    } catch (let e) {
      print(e.localizedDescription)
    }
  }
  
  func drawCard() throws -> CardDeck.DeckCard {
    return try deck.removeLastCard()
  }
  
}

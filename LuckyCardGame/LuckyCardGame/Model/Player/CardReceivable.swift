//
//  CardReceivable.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/10/23.
//

import Foundation

protocol CardReceivable {
  associatedtype CardDeck: Deck
  func receiveCard(_ card: CardDeck.DeckCard)
}
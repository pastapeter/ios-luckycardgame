//
//  DeckProtocol.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

protocol DeckProtocol {
  associatedtype DeckCard
  var cards: [DeckCard] { get }
  func add(card: DeckCard) throws
  func removeLastCard() throws -> DeckCard
  func shuffle()
  func printDeck()
}

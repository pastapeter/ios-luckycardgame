//
//  DeckProtocol.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

protocol DeckProtocol {
  var cards: [LuckyCard] { get }
  func add(card: LuckyCard) throws
  func removeLastCard() throws -> LuckyCard
  func shuffle()
  func printDeck()
}

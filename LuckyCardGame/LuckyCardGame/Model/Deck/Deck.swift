//
//  DeckProtocol.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

protocol Deck {
  var cards: [LuckyCard] { get }
  func add(card: LuckyCard) throws
  func maxByValue() -> LuckyCard?
  func minByValue() -> LuckyCard?
  func removeLastCard() throws -> LuckyCard
  func count() -> Int
  func remove(card: LuckyCard) throws
  func removeLast(to number: Int) -> [LuckyCard]
  func shuffle()
  func sort(ascending: Bool)
  func printDeck()
  func search(where predicate:(LuckyCard) -> Bool) -> Bool
}


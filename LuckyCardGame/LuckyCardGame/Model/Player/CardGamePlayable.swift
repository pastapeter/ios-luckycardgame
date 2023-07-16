//
//  CardGamePlayable.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/7/23.
//

import Foundation

protocol CardSortable {
  func sort(ascending: Bool)
}

protocol CardGameBoardComponent: CardReceivable, CardCountable, CardAccessible, CardSortable {
  func maxCardsOfDeck() -> [LuckyCard]
  func minCardsOfDeck() -> [LuckyCard]
  func max() -> LuckyCard?
  func min() -> LuckyCard?
  func getCardFromDeck(in index: Int) -> LuckyCard?
}


protocol Identifiable {
  var id: String { get }
}

protocol CardgamePlayerable: CardGameBoardComponent, Identifiable {
  func drawCard() throws -> LuckyCard
  func isCurrentPlayer() -> Bool
}

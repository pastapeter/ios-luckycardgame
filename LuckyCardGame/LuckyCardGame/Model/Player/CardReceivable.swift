//
//  CardReceivable.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/10/23.
//

import Foundation

protocol CardReceivable {
  func receiveCard(_ card: LuckyCard)
}

protocol CardAccessible {
  var cards: [LuckyCard] { get }
}

protocol CardCountable {
  func countCardsInDeck() -> Int
}

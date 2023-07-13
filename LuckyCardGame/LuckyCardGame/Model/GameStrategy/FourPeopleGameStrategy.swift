//
//  FourPeopleGameStrategy.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/7/23.
//

import Foundation

final class FourPeopleGameStrategy: GameStrategy {
  func gameStartAlgorithm(_ deck: LuckyCardDeck) -> LuckyGameInstruction {
    deck.shuffle()
    return LuckyGameInstruction(
      cardsSplited:(0..<4).map { _ in return LuckyCardDeck(cards: deck.removeLast(to: 7)) },
      cardsOnField: deck.removeLast(to: 8))
  }
}

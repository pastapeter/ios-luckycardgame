//
//  FourPeopleGameStrategy.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/7/23.
//

import Foundation

class FourPeopleGameStrategy: GameStrategy {
  func gameStartAlgorithm(_ deck: LuckyCardDeck) -> LuckyGameInstruction {
    deck.shuffle()
    CardEmojiType.allCases.forEach {
      do  {
        try deck.remove(card: LuckyCard(type: $0, value: .twelve))
      } catch (let e) { }
    }
    
    return LuckyGameInstruction(
      cardsSplited:(0..<3).map { _ in return LuckyCardDeck(cards: deck.removeLast(to: 8)) },
      cardsOnField: deck.removeLast(to: 9))

  }
}

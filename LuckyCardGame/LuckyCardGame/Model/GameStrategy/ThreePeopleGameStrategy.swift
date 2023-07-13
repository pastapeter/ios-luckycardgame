//
//  ThreePersonGameStrategy.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/7/23.
//

import Foundation

/// 3명기준
/// 전체카드에서 12번 3장을 제외한다. 참가자는 8장씩 갖고, 나머지는 9장을 바닥에 둔다.
class ThreePeopleGameStrategy: GameStrategy {
  
  func gameStartAlgorithm(_ deck: LuckyCardDeck) -> LuckyGameInstruction {
    deck.shuffle()
    CardEmojiType.allCases.forEach {
      do  {
        try deck.remove(card: LuckyCard(type: $0, value: .twelve))
      } catch (let e) {
        print(e.localizedDescription)
      }
    }
    
    return LuckyGameInstruction(
      cardsSplited:(0..<3).map { _ in return LuckyCardDeck(cards: deck.removeLast(to: 8)) },
      cardsOnField: deck.removeLast(to: 9))
  }
  
}

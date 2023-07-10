//
//  GameStrategy.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/7/23.
//

import Foundation

struct LuckyGameInstruction {
  var cardsSplited: [LuckyCardDeck]
  var cardsOnField: [LuckyCard]
}

protocol GameStrategy {
  func gameStartAlgorithm(_ deck: LuckyCardDeck) -> LuckyGameInstruction
}

enum NumberOfPlayer: Int {
  case three = 3
  case four = 4
  case five = 5
  
  var strategy: GameStrategy {
    switch self {
    case .three:
      return ThreePeopleGameStrategy()
    case .four:
      return FourPeopleGameStrategy()
    case .five:
      return FivePeopleGameStrategy()
    }
  }
  
}



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
  func checkForNextTurnAlgorithm(player1: CardgamePlayerable, player2: CardgamePlayerable, cardFromField: LuckyCard) throws -> Bool
}

extension GameStrategy {
  func checkForNextTurnAlgorithm(player1: CardgamePlayerable, player2: CardgamePlayerable, cardFromField: LuckyCard) throws -> Bool {
    
    guard let maxFromFirstPlayer = player1.max(),
          let minFromFirstPlayer = player1.min(),
          let minFromlastPlayer = player2.min(),
          let maxFromlastPlayer = player2.max()
    else { throw GameProceedingError.GameSystemError }
    
    if LuckyCard.isSameValue(minFromlastPlayer, minFromFirstPlayer, cardFromField) {
      return true
    } else if LuckyCard.isSameValue(minFromlastPlayer, maxFromFirstPlayer, cardFromField) {
      return true
    } else if LuckyCard.isSameValue(maxFromlastPlayer, minFromFirstPlayer, cardFromField) {
      return true
    } else if LuckyCard.isSameValue(maxFromlastPlayer, maxFromFirstPlayer, cardFromField) {
      return true
    }
    return false
  }
}

enum NumberOfPlayer: Int, CaseIterable {
  
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



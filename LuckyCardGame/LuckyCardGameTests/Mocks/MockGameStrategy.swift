//
//  MockStrategy.swift
//  LuckyCardGameTests
//
//  Created by Jung peter on 7/17/23.
//

import Foundation
@testable import LuckyCardGame

final class mockGameStrategy: GameStrategy {
  
  private var instruction: LuckyGameInstruction
  
  init(instruction: LuckyGameInstruction) {
    self.instruction = instruction
  }
  
  func gameStartAlgorithm(_ deck: LuckyCardDeck) -> LuckyGameInstruction {
    return instruction
  }
  
}

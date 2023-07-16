//
//  MockGameProceedDelegate.swift
//  LuckyCardGameTests
//
//  Created by Jung peter on 7/16/23.
//

import Foundation
@testable import LuckyCardGame

final class MockGameProceedController: GameProceedDelegate {
  
  func getPlayer(whose id: String) -> CardgamePlayerable? {
    if targetPlayer.id != id { return nil }
    return targetPlayer
  }
  
  func getCurrentPlayer() -> CardgamePlayerable? {
    return currentPlayer
  }
  
  func getCardFromField(in index: Int) -> LuckyCard? {
    return card
  }
  
  var field: CardGameBoardComponent
  var gameStrategy: GameStrategy
  var currentPlayer: CardgamePlayerable
  var targetPlayer: CardgamePlayerable
  var card: LuckyCard
  
  init(gameStrategy: GameStrategy, currentPlayer: CardgamePlayerable, targetPlayer: CardgamePlayerable, card: LuckyCard, field: CardGameBoardComponent) {
    self.gameStrategy = gameStrategy
    self.currentPlayer = currentPlayer
    self.targetPlayer = targetPlayer
    self.card = card
    self.field = field
    
  }
  
}





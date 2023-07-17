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
    return players.first(where: { $0.id == id })
  }
  
  func getCurrentPlayer() -> CardgamePlayerable? {
    return players.first(where: { $0.isCurrentPlayer() })
  }
  
  func getCardFromField(in index: Int) -> LuckyCard? {
    return field.getCardFromDeck(in: index)
  }
  
  var field: CardGameBoardComponent
  var gameStrategy: GameStrategy
  var players: [CardgamePlayerable]
  
  init(gameStrategy: GameStrategy, players: [CardgamePlayerable], field: CardGameBoardComponent) {
    self.gameStrategy = gameStrategy
    self.players = players
    self.field = field
  }
  
}





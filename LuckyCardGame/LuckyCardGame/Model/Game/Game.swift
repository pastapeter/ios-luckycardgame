//
//  Game.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/16/23.
//

import Foundation

enum GameError: Error {
  case invalidNumberofPlayer
}

protocol Game {
  func playerCards() -> [[LuckyCard]]
  func fieldCards() -> [LuckyCard]
  func numberOfPlayer() -> Int
  func startGame()
  func checkStatusForNextTurn(with targetPlayerId: String, cardIndex: Int) throws -> Bool
  func sort(playerId: String)
  func sortCardInField()
}

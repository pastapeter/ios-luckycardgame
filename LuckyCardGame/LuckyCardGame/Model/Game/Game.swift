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
  var players: [CardgamePlayerable] { get }
  var field: CardGameBoardComponent { get }
  func startGame()
  func checkStatusForNextTurn(with targetPlayerId: String, cardIndex: Int) throws -> Bool
}

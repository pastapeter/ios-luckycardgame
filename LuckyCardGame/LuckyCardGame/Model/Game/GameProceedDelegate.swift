//
//  GameProceedDelegate.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/17/23.
//

import Foundation

protocol GameProceedDelegate: AnyObject {
  func getPlayer(whose id: String) -> CardgamePlayerable?
  func getCurrentPlayer() -> CardgamePlayerable?
  func getCardFromField(in index: Int) -> LuckyCard?
  var gameStrategy: GameStrategy { get }
}

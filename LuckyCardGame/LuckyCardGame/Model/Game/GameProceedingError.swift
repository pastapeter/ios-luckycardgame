//
//  GameProceedingError.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/16/23.
//

import Foundation

enum GameProceedingError: LocalizedError {
  case noCurrentPlayerInThisGame
  case noTargetPlayerInThisGame
  case GameSystemError
  
  var errorDescription: String? {
    switch self {
    case .noCurrentPlayerInThisGame:
      return "이 게임에는 현재 사용자가 참여하고 있지않습니다."
    case .noTargetPlayerInThisGame:
      return "이 게임에는 지정하는 플레이어가 참여하고 있지 않습니다."
    case .GameSystemError:
      return "게임시스템에 애러가 있습니다."
    }
  }
}

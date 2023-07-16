//
//  LuckyCardMaker.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

enum LuckyCardMakerError: LocalizedError {
  case generateError(message: String?)
  
  var errorDescription: String? {
    switch self {
    case .generateError(let message):
      return "Generate has Error with \(message ?? "") so Goto Next iteration"
    }
  }
}

/// 내부에 프로퍼티가 존재할 필요 없다.
/// func 자체가 공유해야하는 것도 없다. -> struct
struct LuckyCardMaker {
  
  static func makeCardValue() throws -> CardValue {
    let intDb: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12]
    guard let cardValue = CardValue(rawValue: intDb[Int.random(in: (0..<intDb.count))]) else {
      throw NumberValidationError.notInOneToTweleve
    }
    return cardValue
  }
  
  static func generateRandomly() throws -> LuckyCard {
    do {
      return try LuckyCard(type: CardEmojiType.allCases[Int.random(in: (0...2))], value: makeCardValue())
    } catch(let e){
      throw LuckyCardMakerError.generateError(message: e.localizedDescription)
    }
  }
}

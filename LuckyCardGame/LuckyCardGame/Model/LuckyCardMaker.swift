//
//  LuckyCardMaker.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

/// 내부에 프로퍼티가 존재할 필요 없다.
/// func 자체가 공유해야하는 것도 없다. -> struct
struct LuckyCardMaker {
  
  static func makeIntCardValue() -> some CardValuable {
    let intDb: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12]
    return intDb[Int.random(in: (0..<intDb.count))]
  }
  
  static func makeStrCardValue() -> some CardValuable {
    let strDb: [String] = ["K", "Q", "J" ]
    return strDb[Int.random(in: (0..<strDb.count))]
  }
  
  static func generateRandomly() -> LuckyCard? {
    let randChoice = Int.random(in: (0...1))
    do {
      if randChoice == 0 {
        return try LuckyCard(type: CardEmojiType.allCases[Int.random(in: (0...2))], value: makeIntCardValue())
      } else {
        return try LuckyCard(type: CardEmojiType.allCases[Int.random(in: (0...2))], value: makeStrCardValue())
      }
    } catch(let e){
      print("Generate has Error with \(e.localizedDescription) so Goto Next iteration")
      return nil
    }
  }
}

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
  static func generateRandomly() -> LuckyCard? {
    let db: [any CardValuable] = [1,2,3,4,5,6,7,8,9,10,11,12, "K", "Q", "J"]
    do {
      return try LuckyCard(type: CardType.allCases[Int.random(in: (0...2))], value: db[Int.random(in: (0..<db.count))])
    } catch(let e){
      print("Generate has Error with \(e.localizedDescription) so Goto Next iteration")
      return nil
    }
  }
}

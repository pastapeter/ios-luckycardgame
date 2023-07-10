//
//  LuckyCard.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

// 1번 고민
// Parent or Protocol

// struct를 기반으로 짤때는 주의할 점이 있음
// struct 내부에 참조타입이 있는지 확인해야함
// struct는 복사하기때문에, 내부 RC까지 복사가되서 RC가 높아짐
// swfit의 힙이 rc사이클 + 힙메모리 파편화까지 일어남
enum CardStatus {
  case up
  case down
}

protocol Card: AnyObject, Hashable {
  var status: CardStatus { get set }
  var type: CardEmojiType { get }
  var value: CardValue { get }
  
  func flip()
}

extension Card {
  func flip() { self.status = self.status == .down ? .up : .down }
}


/*
 이 자체로 데이터 타입이어서, Struct를 사용할 수 있다.
 만약 value가 Int였다면, struct를 사용하는 것이 좋을것같다.
 꼭 그렇지 않아도, 예상 가능한 것이라면 struct가 좋다고 생각한다.
 문제는 any CardValuable이다. runtime에 형이 결정된다.
 근데 생각해보면, A가 B에게 Deck을 넘긴다고 했을때, 새로운 것을 넘기는 것인가, 아닌가를 고려한다면, 아니지 않을까 싶다.
 근데 그 내부에 LuckyCard도 상태 공유가 되어야하는것인가?
 이것은 사실 어차피 Deck이 class이고 LuckyCard의 배열을 가지고 있기에, LuckyCard를 struct로 구현하더라도 메모리 성능 관점에서 의미가 있을까라는 생각이 든다.
 그래서 class로 지정한다.
 */

class LuckyCard: Card {
  
  static func == (lhs: LuckyCard, rhs: LuckyCard) -> Bool {
    if lhs.type != rhs.type {
      return false
    } else {
      return lhs.value != rhs.value
    }
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(type)
    hasher.combine(value)
  }
    
  var status: CardStatus
  var type: CardEmojiType
  var value: CardValue
  
  init(type: CardEmojiType, value: CardValue, status: CardStatus) {
    self.type = type
    self.value = value
    self.status = status
  }
  
  convenience init(type: CardEmojiType, value: CardValue) {
    self.init(type: type, value: value, status: .up)
  }
  
}

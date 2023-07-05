//
//  CardType.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

// Swift enum은 강점이 많다.
// 하지만 그럼에도 어떤 Enum이든 OCP를 해결하는 것은 어렵다고 생각한다.
// 그래서 내 기준은 타입이 명확하고, 수정해야하는 사항이 많다고 생각되지 않는 데이터 타입을 만들어야할때 Enum을 사용할 수 있다고 생각한다.
// 예를 들어, 아래와 같이 Type이 명확한 경우, Type에 대해 특정 수정사항이 있을때, 모든 경우를 다 수정해야하는 데이터 타입일 경우는 오히려 Enum으로 강제하는 것이 좋다고 생각한다.
// 또한 하나의 Type을 생성했을때 (확장)의 경우, Enum이 어렵지만
// 내부에 함수나, 계산속성을 많이 두지 않아야한다.
// 많이 필요할 경우, protocol과 struct 혹은 protocol과 class로 변경해야한다.
// CardType에 특정 함수나, 계산 속성이 들어간다고 했을떄, 하나만 적용시키는 일이 없도록

enum CardType: Hashable, CaseIterable {
  
  case Dog
  case Cat
  case Cow
  
  var emojiUnicode: UnicodeScalarType {
    switch self {
    case .Dog:
      return "\u{1F436}"
    case .Cat:
      return "\u{1F431}"
    case .Cow:
      return "\u{1F42E}"
    }
  }
  
}

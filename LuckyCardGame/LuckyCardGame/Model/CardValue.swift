//
//  CardValue.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

protocol StringConvertible {
  var stringValue: String { get }
}

/*
 CardValue는 LuckyCard 내부에 값이다.
 OCP를 구현하기 위해서 protocol을 사용하여 구현했다.
 만약 현재 요구사항은 Int 만을 표시하고 있지만.
 요구사항이 String, Double로 넘어가면 어떻게 변경해야할까를 고민하였다.
 따라서 CardValuable 이라는 protocol을 만들고,
 각 자료형에 CardValuable 을 채택하게 하면, Cardvalue에 들어갈수 있는 자료형은 늘어나게 되고
 결국은 확장에 매우 강하게 된다.
 */
protocol CardValuable: Hashable, StringConvertible {
  var cardValue: Self { get }
}

extension Int: CardValuable {
  var stringValue: String {
    return String(format: "%02d", self)
  }
  
  var cardValue: Int { return self }
}

extension String: CardValuable {
  var stringValue: String {
    return self
  }
  
  var cardValue: String { return self }
}

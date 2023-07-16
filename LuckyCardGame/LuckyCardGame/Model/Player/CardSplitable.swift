//
//  CardDealable.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/10/23.
//

import Foundation

protocol CardSplitable {
  func splitCard(to other: CardReceivable, cards: [LuckyCard])
}

// 왜 generic을 가져가면 애니인가
extension CardSplitable {
  func splitCard(to other: CardReceivable, cards: [LuckyCard]) {
    for card in cards {
      other.receiveCard(card)
    }
  }
}

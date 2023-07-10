//
//  CardDealable.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/10/23.
//

import Foundation

protocol CardgameDealable {
  func splitCard<Receiver: CardReceivable>(to other: Receiver, cards: [Receiver.CardDeck.DeckCard])
}

extension CardgameDealable {
  func splitCard<Receiver: CardReceivable>(to other: Receiver, cards: [Receiver.CardDeck.DeckCard]) {
    for card in cards {
      other.receiveCard(card)
    }
  }
}

//
//  Deck.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

enum DeckError: LocalizedError {
  case DuplicateCard
  case DeckIsEmpty
  
  var errorDescription: String? {
    switch self {
    case .DuplicateCard:
      return "카드가 중복됩니다."
    case .DeckIsEmpty:
      return "덱에 카드가 없습니다."
    }
  }
}


/// Deck은 Class로 구현한다.
/// 내부에 참조타입이 있는 경우, 보통 Class로 구현하는 편이다.
/// 서로 다른 객체들이 서로 상태를 공유하거나 변경을 해야할때는 Class를 사용한다.
final class Deck: DeckProtocol {
  
  var cards: [LuckyCard] = []
  
  init(cards: [LuckyCard]) {
    self.cards = cards
  }
  
  func add(card: LuckyCard) throws {
    if Set(cards).intersection(Set([card])).count > 0 {
      throw DeckError.DuplicateCard
    }
    cards.insert(card, at: 0)
  }
  
  func removeLastCard() throws -> LuckyCard {
    if cards.isEmpty { throw DeckError.DeckIsEmpty }
    return cards.removeLast()
  }
  
  func shuffle() {
    cards.shuffle()
  }
  
  
  func printDeck() {
    cards.forEach {
      print("\($0.type.emojiUnicode)\($0.value.stringValue)", terminator: ", ")
    }
  }
  
}

extension Deck: RandomBuildable {
  static func makeRandomly() -> Deck {
    return Deck(cards: (0...(CardEmojiType.allCases.count * 12)).compactMap { _ in
      LuckyCardMaker.generateRandomly()
    })
  }
  
  static func make(cards: [LuckyCard]) -> Deck {
    return Deck(cards: cards)
  }
}

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
  case noCardInDeck
  
  var errorDescription: String? {
    switch self {
    case .DuplicateCard:
      return "카드가 중복됩니다."
    case .DeckIsEmpty:
      return "덱에 카드가 없습니다."
    case .noCardInDeck:
      return "덱에 해당 카드가 없습니다."
    }
  }
}


/// Deck은 Class로 구현한다.
/// 내부에 참조타입이 있는 경우, 보통 Class로 구현하는 편이다.
/// 서로 다른 객체들이 서로 상태를 공유하거나 변경을 해야할때는 Class를 사용한다.
///
final class LuckyCardDeck: Deck {
  
  typealias DeckCard = LuckyCard
  var cards: [DeckCard] = []
  
  init(cards: [DeckCard]) {
    self.cards = cards
  }
  
  func add(card: DeckCard) throws {
    if Set(cards).intersection(Set([card])).count > 0 {
      throw DeckError.DuplicateCard
    }
    cards.insert(card, at: 0)
  }
  
  func removeLastCard() throws -> DeckCard {
    if cards.isEmpty { throw DeckError.DeckIsEmpty }
    return cards.removeLast()
  }
  
  func shuffle() {
    cards.shuffle()
  }
  
  func remove(card: LuckyCard) throws {
    if let index = cards.firstIndex(of: card) {
      cards.remove(at: index)
      return
    }
    throw DeckError.noCardInDeck
  }
  
  func removeLast(to number: Int) -> [LuckyCard] {
    var newCards: [LuckyCard] = []
    if number <= 0 { return newCards }
    for _ in (0..<number) {
      do {
        newCards.append(try self.removeLastCard())
      } catch { break }
    }
    return newCards
  }
  
  func printDeck() {
    cards.forEach {
      print("\($0.type.emojiUnicode)\($0.value.description)", terminator: ", ")
    }
  }
  
}

extension LuckyCardDeck: RandomBuildable {
  static func makeRandomly() -> LuckyCardDeck {
    return LuckyCardDeck(cards: (0...(CardEmojiType.allCases.count * 12)).compactMap { _ in
      LuckyCardMaker.generateRandomly()
    })
  }
  
  static func make() -> LuckyCardDeck {
    return LuckyCardDeck(cards: [])
  }
  
  static func make(cards: [LuckyCard]) -> LuckyCardDeck {
    return LuckyCardDeck(cards: cards)
  }
}

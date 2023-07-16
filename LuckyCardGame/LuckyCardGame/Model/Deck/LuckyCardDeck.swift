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
  
  private(set) var cards: [LuckyCard] = []
  
  init(cards: [LuckyCard]) {
    self.cards = cards
  }
  
  convenience init() {
    var cards: [LuckyCard] = []
    for emoji in CardEmojiType.allCases {
      for value in CardValue.allCases {
        cards.append(LuckyCard(type: emoji, value: value))
      }
    }
    self.init(cards: cards)
  }
  
  func count() -> Int {
    return cards.count
  }
  
  func maxCards() -> [LuckyCard] {
    guard let maxCard = maxByValue() else { return [] }
    return cards.filter { $0.value == maxCard.value }
  }
  
  func minCards() -> [LuckyCard] {
    guard let minCard = minByValue() else { return [] }
    return cards.filter { $0.value == minCard.value }
  }
  
  func maxByValue() -> LuckyCard? {
    return cards.max { $0.value < $1.value }
  }
  
  func minByValue() -> LuckyCard? {
    return cards.min(by: { $0.value < $1.value })
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
      } catch {
        return []
      }
    }
    return newCards
  }
  
  func printDeck() {
    cards.forEach {
      print("\($0.type.emojiUnicode)\($0.value.description)", terminator: ", ")
    }
  }
  
  func sort(ascending: Bool = true) {
    if ascending {
      cards.sort(by: <)
    } else {
      cards.sort(by: >)
    }
    
  }
  
  func search(where predicate: (LuckyCard) -> Bool) -> Bool {
    return cards.contains(where: predicate)
  }
  
}

extension LuckyCardDeck: RandomBuildable {
  static func makeRandomly() -> LuckyCardDeck {
    return LuckyCardDeck(cards: (0...(CardEmojiType.allCases.count * 12)).compactMap { _ in
      return try? LuckyCardMaker.generateRandomly()
    })
  }
}

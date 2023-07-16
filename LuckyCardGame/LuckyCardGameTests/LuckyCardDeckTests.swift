//
//  LuckyCardDeckTests.swift
//  LuckyCardGameTests
//
//  Created by Jung peter on 7/13/23.
//

import XCTest
@testable import LuckyCardGame

final class LuckyCardDeckTests: XCTestCase {
  
  var sut: LuckyCardDeck!
  
  override func setUpWithError() throws {
    sut = LuckyCardDeck()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  // MARK: - Given Helper Function
  func givenAllCards() -> [LuckyCard] {
    var cards: [LuckyCard] = []
    for emoji in CardEmojiType.allCases {
      for value in CardValue.allCases {
        cards.append(LuckyCard(type: emoji, value: value))
      }
    }
    return cards
  }
  
  // MARK: - Cases
  func
  test_LuckyCardDeck이_파라미터없이초기화할때_전체카드가생성되는지() throws {
    //given
    let input: [LuckyCard] = givenAllCards()
    //when
    //then
    XCTAssertEqual(sut.cards, input)
  }
  
  func test_LuckyCardDeck이_파라미터로초기화할때_카드가동일하게들어가는지() throws {
    //given
    let input: [LuckyCard] = [
      LuckyCard(type: .Cat, value: .one),
      LuckyCard(type: .Dog, value: .two),
      LuckyCard(type: .Cow, value: .three)
    ]
    
    //when
    sut = LuckyCardDeck(cards: input)
    //then
    XCTAssertEqual(sut.cards, input)
  }
  
  func test_꽉찬LuckyCardDeck에_add함수로_동일한카드추가하면_DuplicateCard애러발생하는지() throws {
    // given
    let input = LuckyCard(type: .Cat, value: .one)
    
    //when
    //then
    let exp = DeckError.DuplicateCard
    
    XCTAssertThrowsError(try sut.add(card: input)) { error in
      XCTAssertEqual(exp, error as? DeckError)
    }
  }
  
  func test_LuckycardDeck에_add함수를호출했을때_맨앞에쌓이는지() throws {
    //given
    let input = LuckyCard(type: .Cat, value: .one)
    sut = LuckyCardDeck(cards: [
      LuckyCard(type: .Cow, value: .one),
      LuckyCard(type: .Dog, value: .one)
    ])
    
    //when
    try sut.add(card: input)
    
    //then
    XCTAssertEqual(sut.cards[0], input)
    
  }
  
  func test_LuckyCardDeck가_비었을때_removeLastCard를부르면_DeckIsEmpty애러를_뿜는지() throws {
    //given
    sut = LuckyCardDeck(cards: [])
    
    //when
    //then
    let exp = DeckError.DeckIsEmpty
    XCTAssertThrowsError(try sut.removeLastCard()) { error in
      XCTAssertEqual(exp, error as? DeckError)
    }
  }
  
  func test_LuckyCardDeck에_지우려는카드가_없을때_removecard를부르면_noCardInDeck애러를뿜는지() throws {
    //given
    sut = LuckyCardDeck(cards: [LuckyCard(type: .Cat, value: .one)])
    let input = LuckyCard(type: .Cat, value: .ten)
    
    //when
    //then
    let exp = DeckError.noCardInDeck
    XCTAssertThrowsError(try sut.remove(card: input)) { error in
      XCTAssertEqual(exp, error as? DeckError)
    }
  }
  
  func test_LuckyCardDeck에서_sort함수를부르면_오름차순으로정렬이되는지() throws {
    //given
    let input = givenAllCards().sorted()
    
    //when
    sut.sort()
    
    //then
    XCTAssertEqual(input, sut.cards)
  }
  
  func test_LuckyCardDeck에서_sort_ascending_false함수를부르면_내림차순정렬이되는지() throws {
    //given
    let input = givenAllCards().sorted(by: >)
    
    //when
    sut.sort(ascending: false)
    
    //then
    XCTAssertEqual(input, sut.cards)
  }
  
  func test_LuckyCardDeck에서_search함수를통해_card를찾을수있을지() throws {
    //given
    let input = LuckyCard(type: .Cat, value: .eight)
    //when
    let result = sut.search {
      $0 == input
    }
    
    XCTAssertTrue(result)
  }
  
  func test_LuckyCardDeck에서_maxvalue함수를통해_가장큰값을가진카드를_찾을수있을지() throws {
    //given
    let input = [ LuckyCard(type: .Cat, value: .eight), LuckyCard(type: .Cow, value: .nine), LuckyCard(type: .Cow, value: .eight)]
    
    sut = LuckyCardDeck(cards: input)
    
    let exp = input.max(by: { $0.value < $1.value})
    XCTAssertEqual(sut.maxByValue(), exp)
  }
  
  
  func test_minValue함수를통해_가장작은값을가진카드를찾을수있는지() throws {
    //given
    let input = [ LuckyCard(type: .Cat, value: .eight), LuckyCard(type: .Cow, value: .nine), LuckyCard(type: .Cow, value: .eight)]
    
    sut = LuckyCardDeck(cards: input)
    
    let exp = input.min(by: { $0.value < $1.value})
    XCTAssertEqual(sut.minByValue(), exp)
  }
  
  func test_maxValue함수에서는_동일한값을가지더라도_순서대로빠지는가() throws {
    //given
    let input = [ LuckyCard(type: .Cat, value: .eight), LuckyCard(type: .Cow, value: .eight), LuckyCard(type: .Dog, value: .eight)]
    
    sut = LuckyCardDeck(cards: input)
    
    let exp = input.max(by: { $0.value < $1.value})
    XCTAssertEqual(sut.maxByValue(), exp)
  }
  
}



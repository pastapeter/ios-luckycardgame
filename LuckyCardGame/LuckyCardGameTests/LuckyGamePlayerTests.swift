//
//  LuckyGamePlayerTests.swift
//  LuckyCardGameTests
//
//  Created by Jung peter on 7/12/23.
//

import XCTest
@testable import LuckyCardGame

final class LuckyGamePlayerTests: XCTestCase {
  
  var sut: LuckyCardGamePlayer!
  let deck = LuckyCardDeck()
  let id = "A"
  let currentPlayer = "A"
  
  override func setUpWithError() throws {
    sut = LuckyCardGamePlayer(deck: deck, id: id)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  
  //given helper function
  
  func makeEmptyDeck() -> LuckyCardDeck {
    return LuckyCardDeck(cards: [])
  }
  
  func givenAllCards() -> [LuckyCard] {
    var cards: [LuckyCard] = []
    for emoji in CardEmojiType.allCases {
      for value in CardValue.allCases {
        cards.append(LuckyCard(type: emoji, value: value))
      }
    }
    return cards
  }
  
  func test_cards를부르면_deck의cards와동일한지() throws {
    
    //given
    //when
    
    //then
    XCTAssertEqual(sut.cards, deck.cards)
    
  }
  
  func test_receiveCard를부르면_deck에card가쌓이는지() {
    
    //given
    let input = LuckyCard(type: .Cat, value: .eight)
    sut = LuckyCardGamePlayer(deck: makeEmptyDeck(), id: id)
    
    //when
    sut.receiveCard(input)
    
    XCTAssertEqual(sut.cards, [input])
    
  }
  
  func test_receiveCard를부르는사람이_현재플레이어면_deck에Card가쌓일때_뒤집혀서쌓이는지() {
    //given
    let givenState: CardStatus = .down
    let input = LuckyCard(type: .Cat, value: .eight, status: givenState)
    sut = LuckyCardGamePlayer(deck: makeEmptyDeck(), id: currentPlayer)
    
    //when
    sut.receiveCard(input)
    
    //when
    XCTAssertNotEqual(givenState, try sut.drawCard().status)
  }

  
  func test_receiveCard를부르면_cardstatus가복사되지않는지() {
    let givenState: CardStatus = .down
    let input = LuckyCard(type: .Cat, value: .eight, status: givenState)
    sut = LuckyCardGamePlayer(deck: makeEmptyDeck(), id: currentPlayer)
    
    //when
    sut.receiveCard(input)
    
    //when
    XCTAssertEqual(input.status, try sut.drawCard().status)
  }
  
  func test_count를부르면_player가가진deckcards수를_방출하는지() {
    //given
    let input = LuckyCardDeck(cards: givenAllCards())
    sut = LuckyCardGamePlayer(deck: input, id: currentPlayer)
    
    //when
    //then
    XCTAssertEqual(sut.countCardsInDeck(), input.count())
  }
  
  func test_drawCard를부르면_가장마지막카드를주는지() {
    //given
    let input = [ LuckyCard(type: .Cat, value: .one),
                  LuckyCard(type: .Cow, value: .two) ]
    
    sut = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: input), id: currentPlayer)
    
    //when
    let exp = input[1]
    
    //then
    XCTAssertEqual(try sut.drawCard(), exp)
    
  }
  
  func test_isCardTriple을불렀을때_3장의값의중복카드가있다면_true인지() throws {
    
    //given
    let input = [ LuckyCard(type: .Cat, value: .one),
                  LuckyCard(type: .Dog, value: .one),
                  LuckyCard(type: .Cow, value: .one)
    ]
    
    sut = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: input), id: currentPlayer)
    
    //when
    //then
    XCTAssertTrue(sut.isCardTriple())
    
  }
  
  func test_isCardTriple을불렀을때_3장의중복카드가없다면_false인지() throws {
    
    //given
    let input =  [ LuckyCard(type: .Cat, value: .one),
                   LuckyCard(type: .Dog, value: .two),
                   LuckyCard(type: .Cow, value: .three)
     ]
    sut = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: input), id: currentPlayer)
    
    //when
    //then
    XCTAssertFalse(sut.isCardTriple())
  }
  
  
  
  
}

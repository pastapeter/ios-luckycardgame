//
//  LuckyGameTests.swift
//  LuckyCardGameTests
//
//  Created by Jung peter on 7/12/23.
//

import XCTest
@testable import LuckyCardGame

final class LuckyGameTests: XCTestCase {
  
  var sut: LuckyCardGame!
  var cards1 = [LuckyCard(type: .Cat, value: .eight)]
  var cards2 = [LuckyCard(type: .Cow, value: .eight)]
  var cards3 = [LuckyCard(type: .Dog, value: .nine)]
  var cardForField = [LuckyCard(type: .Dog, value: .eight)]
  
  override func setUpWithError() throws {
    let mockDealer = MockDealer(playerCards: [cards1, cards2, cards3], fieldCards: cardForField)
    let mockStrategy = mockGameStrategy(instruction: LuckyGameInstruction(cardsSplited: [], cardsOnField: []))
    sut = LuckyCardGame(players: mockDealer.players, dealer: mockDealer, gameStrategy: mockStrategy, field: mockDealer.field)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
// MARK: - Player는 3명
  
  func test_startGame이불렸을때_카드가나눠져있는지() throws {
    
    //when
    sut.startGame()
    
    //then
    XCTAssertEqual(sut.players[0].cards, cards1)
    XCTAssertEqual(sut.players[1].cards, cards2)
    XCTAssertEqual(sut.players[2].cards, cards3)
    XCTAssertEqual(sut.field.cards, cardForField)

  }
  
  func test_checkStatusForNextTurn함수가불렸을때_카드3개의값이같은경우_true를반환하는지() throws {
    
    //given
    var cards1 = [LuckyCard(type: .Cat, value: .eight)]
    var cards2 = [LuckyCard(type: .Cow, value: .eight)]
    var cards3 = [LuckyCard(type: .Dog, value: .nine)]
    var cardForField = [LuckyCard(type: .Dog, value: .eight)]
    
    let mockDealer = MockDealer(playerCards: [cards1, cards2, cards3], fieldCards: cardForField)
    let mockStrategy = mockGameStrategy(instruction: LuckyGameInstruction(cardsSplited: [LuckyCardDeck(cards: cards1), LuckyCardDeck(cards: cards2), LuckyCardDeck(cards: cards3)], cardsOnField: cardForField))
    sut = LuckyCardGame(players: mockDealer.players, dealer: mockDealer, gameStrategy: mockStrategy, field: mockDealer.field)
    mockDealer.setDelegateForProceedGame(with: sut)
    
    sut.startGame()
    
    
//    when
//    then
    
    XCTAssertTrue(try sut.checkStatusForNextTurn(with: "B", cardIndex: 0))
    
  }
  
  func test_checkStatusForNextTurn함수가불렸을때_카드3개의값이다른경우_false를반환하는지() throws {
    //given
    var cards1 = [LuckyCard(type: .Cat, value: .eight)]
    var cards2 = [LuckyCard(type: .Cow, value: .ten)]
    var cards3 = [LuckyCard(type: .Dog, value: .nine)]
    var cardForField = [LuckyCard(type: .Dog, value: .one)]
    
    let mockDealer = MockDealer(playerCards: [cards1, cards2, cards3], fieldCards: cardForField)
    let mockStrategy = mockGameStrategy(instruction: LuckyGameInstruction(cardsSplited: [LuckyCardDeck(cards: cards1), LuckyCardDeck(cards: cards2), LuckyCardDeck(cards: cards3)], cardsOnField: cardForField))
    sut = LuckyCardGame(players: mockDealer.players, dealer: mockDealer, gameStrategy: mockStrategy, field: mockDealer.field)
    mockDealer.setDelegateForProceedGame(with: sut)
    sut.startGame()
    
    //when
    //then
    XCTAssertFalse(try sut.checkStatusForNextTurn(with: "C", cardIndex: 0))
  }
  
  func test_checkStatusForNextTurn함수가불렸을때_TargetPlayerId가없는경우_Error를반환하는지() throws {
    //given
    var cards1 = [LuckyCard(type: .Cat, value: .eight)]
    var cards2 = [LuckyCard(type: .Cow, value: .ten)]
    var cards3 = [LuckyCard(type: .Dog, value: .nine)]
    var cardForField = [LuckyCard(type: .Dog, value: .one)]
    
    let mockDealer = MockDealer(playerCards: [cards1, cards2, cards3], fieldCards: cardForField)
    let mockStrategy = mockGameStrategy(instruction: LuckyGameInstruction(cardsSplited: [LuckyCardDeck(cards: cards1), LuckyCardDeck(cards: cards2), LuckyCardDeck(cards: cards3)], cardsOnField: cardForField))
    sut = LuckyCardGame(players: mockDealer.players, dealer: mockDealer, gameStrategy: mockStrategy, field: mockDealer.field)
    
    mockDealer.setDelegateForProceedGame(with: sut)
    sut.startGame()
    
    //when
    //then
    XCTAssertThrowsError(try sut.checkStatusForNextTurn(with: "E", cardIndex: 0))
  }
  
  func test_getPlayer함수불렀을때_id가같은경우Nil이아닌지() {
    
    //given
    let input = "C"
    
    //when
    //then
    XCTAssertNotNil(sut.getPlayer(whose: input))
    
  }
  
  func test_getCurrentPlayer함수를불렀을때_nil이아닌지() {
    
    //given
    //when
    //then
    XCTAssertNotNil(sut.getCurrentPlayer())
    
  }
  
  func test_sort함수를불렀을때_지정한player만되는지() {
    //given
    var cards1 = [LuckyCard(type: .Cat, value: .eight), LuckyCard(type: .Cat, value: .ten), LuckyCard(type: .Cat, value: .eleven), LuckyCard(type: .Cat, value: .one), LuckyCard(type: .Cat, value: .two), LuckyCard(type: .Cat, value: .seven)]
    var cards2 = [LuckyCard(type: .Cow, value: .ten), LuckyCard(type: .Cow, value: .one), LuckyCard(type: .Cow, value: .seven)]
    var cards3 = [LuckyCard(type: .Dog, value: .nine)]
    var cardForField = [LuckyCard(type: .Dog, value: .one)]
    
    let mockDealer = MockDealer(playerCards: [cards1, cards2, cards3], fieldCards: cardForField)
    let mockStrategy = mockGameStrategy(instruction: LuckyGameInstruction(cardsSplited: [LuckyCardDeck(cards: cards1), LuckyCardDeck(cards: cards2), LuckyCardDeck(cards: cards3)], cardsOnField:cardForField))
    sut = LuckyCardGame(players: mockDealer.players, dealer: mockDealer, gameStrategy: mockStrategy, field: mockDealer.field)
    
    mockDealer.setDelegateForProceedGame(with: sut)
    sut.startGame()
    
    //when
    sut.sort(playerId: currentUserName)
    
    //then
    let exp = cards1.sorted()
    let currentPlayer = sut.getCurrentPlayer()
    XCTAssertEqual(currentPlayer?.cards, exp)
    XCTAssertNotEqual(sut.getPlayer(whose: "B")?.cards, cards2.sorted(by: {$0.value < $1.value}))
    
  }
  
  func test_getCardFromField함수를불렀을때_field위의카드보다큰index일경우_nil인지() {
    //given
    let input = cards3.count + 1
    sut.startGame()
    
    //when
    //then
    XCTAssertNil(sut.getCardFromField(in: input))
  }
  
  func test_sortcardsInField함수를불렀을때_field위의카드가정렬되는가() {
    
    //given
    let input = [LuckyCard(type: .Dog, value: .one), LuckyCard(type: .Dog, value: .eleven), LuckyCard(type: .Dog, value: .eight)]
    var cards1 = [LuckyCard(type: .Cat, value: .eight), LuckyCard(type: .Cat, value: .ten), LuckyCard(type: .Cat, value: .eleven), LuckyCard(type: .Cat, value: .one), LuckyCard(type: .Cat, value: .two), LuckyCard(type: .Cat, value: .seven)]
    var cards2 = [LuckyCard(type: .Cow, value: .ten), LuckyCard(type: .Cow, value: .one), LuckyCard(type: .Cow, value: .seven)]
    var cards3 = [LuckyCard(type: .Dog, value: .nine)]
    var cardForField = input
    
    var cardCollections = [cards1, cards2, cards3, cardForField]
    
    let mockDealer = MockDealer(playerCards: [cards1, cards2, cards3], fieldCards: cardForField)
    let mockStrategy = mockGameStrategy(instruction: LuckyGameInstruction(cardsSplited: [LuckyCardDeck(cards: cards1), LuckyCardDeck(cards: cards2), LuckyCardDeck(cards: cards3)], cardsOnField:cardForField))
    sut = LuckyCardGame(players: mockDealer.players, dealer: mockDealer, gameStrategy: mockStrategy, field: mockDealer.field)
    
    mockDealer.setDelegateForProceedGame(with: sut)
    sut.startGame()
    
    //when
    sut.sortCardInField()
    //then
    let exp = input.sorted(by: { $0.value < $1.value })
    XCTAssertEqual(sut.field.cards, exp)
    
  }
  
  
}

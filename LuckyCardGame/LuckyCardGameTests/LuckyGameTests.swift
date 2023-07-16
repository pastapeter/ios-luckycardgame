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
  var cards3 = [LuckyCard(type: .Dog, value: .eight)]
  
  override func setUpWithError() throws {
    let mockDealer = MockDealer(currentPlayerCards: cards1, targetPlayerCards: cards2, fieldCards: cards3)
    let mockStrategy = mockGameStrategy(instruction: LuckyGameInstruction(cardsSplited: [], cardsOnField: []))
    sut = LuckyCardGame(players: [mockDealer.currentPlayer, mockDealer.targetPlayer], dealer: mockDealer, gameStrategy: mockStrategy, field: mockDealer.field)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_startGame이불렸을때_카드가나눠져있는지() throws {
    
    //when
    sut.startGame()
    
    //then
    XCTAssertEqual(sut.players[0].cards, cards1)
    XCTAssertEqual(sut.players[1].cards, cards2)
    XCTAssertEqual(sut.field.cards, cards3)
    
  }
  
  func test_checkStatusForNextTurn함수가불렸을때_카드3개의값이같은경우_true를반환하는지() throws {
    
    //given
    var cards1 = [LuckyCard(type: .Cat, value: .eight)]
    var cards2 = [LuckyCard(type: .Cow, value: .eight)]
    var cards3 = [LuckyCard(type: .Dog, value: .eight)]
    let mockDealer = MockDealer(currentPlayerCards: cards1, targetPlayerCards: cards2, fieldCards: cards3)
    let mockStrategy = mockGameStrategy(instruction: LuckyGameInstruction(cardsSplited: [], cardsOnField: []))
    sut = LuckyCardGame(players: [mockDealer.currentPlayer, mockDealer.targetPlayer], dealer: mockDealer, gameStrategy: mockStrategy, field: mockDealer.field)
    mockDealer.setDelegateForProceedGame(with: sut)
    
    sut.startGame()
    
    
//    when
//    then
    
    XCTAssertTrue(try sut.checkStatusForNextTurn(with: "D", cardIndex: 0))
    
  }
  
  func test_checkStatusForNextTurn함수가불렸을때_카드3개의값이다른경우_false를반환하는지() throws {
    //given
    var cards1 = [LuckyCard(type: .Cat, value: .eight)]
    var cards2 = [LuckyCard(type: .Cow, value: .one)]
    var cards3 = [LuckyCard(type: .Dog, value: .two)]
    let mockDealer = MockDealer(currentPlayerCards: cards1, targetPlayerCards: cards2, fieldCards: cards3)
    let mockStrategy = mockGameStrategy(instruction: LuckyGameInstruction(cardsSplited: [], cardsOnField: []))
    sut = LuckyCardGame(players: [mockDealer.currentPlayer, mockDealer.targetPlayer], dealer: mockDealer, gameStrategy: mockStrategy, field: mockDealer.field)
    mockDealer.setDelegateForProceedGame(with: sut)
    sut.startGame()
    
    //when
    //then
    XCTAssertFalse(try sut.checkStatusForNextTurn(with: "D", cardIndex: 0))
  }
  
  func test_checkStatusForNextTurn함수가불렸을때_TargetPlayerId가없는경우_Error를반환하는지() throws {
    //given
    var cards1 = [LuckyCard(type: .Cat, value: .eight)]
    var cards2 = [LuckyCard(type: .Cow, value: .one)]
    var cards3 = [LuckyCard(type: .Dog, value: .two)]
    let mockDealer = MockDealer(currentPlayerCards: cards1, targetPlayerCards: cards2, fieldCards: cards3)
    let mockStrategy = mockGameStrategy(instruction: LuckyGameInstruction(cardsSplited: [], cardsOnField: []))
    sut = LuckyCardGame(players: [mockDealer.currentPlayer, mockDealer.targetPlayer], dealer: mockDealer, gameStrategy: mockStrategy, field: mockDealer.field)
    
    sut.startGame()
    
    //when
    //then
    XCTAssertThrowsError(try sut.checkStatusForNextTurn(with: "E", cardIndex: 0))
  }
  
  func test_getPlayer함수불렀을때_id가같은경우Nil이아닌지() {
    
    //given
    let input = "D"
    
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
  
  func test_getCardFromField함수를불렀을때_field위의카드보다큰index일경우_nil인지() {
    //given
    let input = cards3.count + 1
    sut.startGame()
    
    //when
    //then
    XCTAssertNil(sut.getCardFromField(in: input))
  }
  
  
}

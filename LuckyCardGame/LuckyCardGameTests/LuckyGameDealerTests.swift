//
//  LuckyGameDealerTests.swift
//  LuckyCardGameTests
//
//  Created by Jung peter on 7/12/23.
//

import XCTest
@testable import LuckyCardGame

final class LuckyGameDealerTests: XCTestCase {
  
  var sut: LuckyCardDealer!
  var field: CardGameBoardComponent!
  var mockGameProceedController: GameProceedDelegate!
  var card: LuckyCard! = LuckyCard(type: .Cat, value: .one)
  
  
  override func setUpWithError() throws {
    
    var instruction = LuckyGameInstruction(cardsSplited: [], cardsOnField: [])
    var mockStrategy = mockGameStrategy(instruction: instruction)
    var currentPlayer = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: []), id: currentUserName)
    var targetPlayer = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: []), id: "D")
    field = LuckyGameField(deck: LuckyCardDeck(cards: []))
    mockGameProceedController = MockGameProceedController(gameStrategy: mockStrategy, currentPlayer: currentPlayer, targetPlayer: targetPlayer, card: card, field: field)
    
    sut = LuckyCardDealer(deck: LuckyCardDeck(), gameProceedDelegate: mockGameProceedController)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    field = nil
    card = nil
    mockGameProceedController = nil
  
  }
  
  // MARK: - Given Helper Function
  
  func makeInstruction(for currentPlayerDeck: LuckyCardDeck, for targetDeck: LuckyCardDeck, cardsOnfield: [LuckyCard]) -> LuckyGameInstruction {
    return LuckyGameInstruction(cardsSplited: [currentPlayerDeck, targetDeck], cardsOnField: cardsOnfield)
  }
  
  func makeMockGameProceedController(
    instruction: LuckyGameInstruction,
    currentPlayer: CardgamePlayerable,
    targetPlayer: CardgamePlayerable,
    card: LuckyCard,
    field: CardGameBoardComponent
  ) -> MockGameProceedController {
    return MockGameProceedController(
      gameStrategy: mockGameStrategy(instruction: instruction),
      currentPlayer: currentPlayer,
      targetPlayer: targetPlayer,
      card: card,
      field: field)
  }
  
  
  func test_gameStart를불렀을때_gameStrategy의instruction에맞게나눠지는지() throws {
   
    //given
    var currentPlayer = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: []), id: currentUserName)
    var targetPlayer = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: []), id: "D")
    field = LuckyGameField(deck: LuckyCardDeck(cards: []))
    
    
    var DeckForCurPlayer = LuckyCardDeck(cards: [LuckyCard(type: .Cat, value: .two)])
    var DeckForTargetPlayer = LuckyCardDeck(cards: [LuckyCard(type: .Cat, value: .three)])
    var cardsOnField : [LuckyCard] = [LuckyCard(type: .Cat, value: .four)]
    
    let instruction = LuckyGameInstruction(cardsSplited: [DeckForCurPlayer, DeckForTargetPlayer], cardsOnField: cardsOnField)
    
    //sut이 참조하고있는 mock
    let mock = makeMockGameProceedController(instruction: instruction,currentPlayer: currentPlayer, targetPlayer: targetPlayer, card: card, field: field)
    
    sut = LuckyCardDealer(deck: LuckyCardDeck(),
                          gameProceedDelegate: mock)

    //when
    sut.gameStart(with: [currentPlayer, targetPlayer], on: field)
    //then
    XCTAssertEqual(mock.currentPlayer.cards, DeckForCurPlayer.cards)
    XCTAssertEqual(mock.targetPlayer.cards, DeckForTargetPlayer.cards)
    XCTAssertEqual(mock.field.cards, cardsOnField)
    
    
  }
  
  func test_receiveCard를불렀을때_dealer의deck에_카드가쌓이는지() throws {
    
    //given
    sut = LuckyCardDealer(deck: LuckyCardDeck(cards: []), gameProceedDelegate: nil)
    let input = LuckyCard(type: .Cat, value: .eight)
    
    //when
    sut.receiveCard(input)
    
    XCTAssertEqual(sut.cards[0], input)
    
  }
  
  func test_checkCard를불렀을때_targetPlayer가없으면_noTargetPlayerError가나는지() throws {
    
    //given
    let input = "H"
    
    //when
    //then
    let exp = GameProceedingError.noTargetPlayerInThisGame
    XCTAssertThrowsError(try sut.checkCards(with: input, fieldCardIndex: 0)) { error in
      XCTAssertEqual(exp, error as? GameProceedingError)
    }

  }
  
  func test_checkCard를불렀을떄_delegate이없으면_GameSystemError발생하는지() {
    //given
    sut = LuckyCardDealer(deck: LuckyCardDeck(), gameProceedDelegate: nil)
    
    let exp = GameProceedingError.GameSystemError
    XCTAssertThrowsError(try sut.checkCards(with: "D", fieldCardIndex: 0)) { error in
      XCTAssertEqual(exp, error as? GameProceedingError)
    }
  }
  
  
  func test_gameStart이후_checkCard를불렀을때_모두같은CardValue가있다면_True리턴하는지() {
    
    //given
    let deck1 = LuckyCardDeck(cards: [ LuckyCard(type: .Cat, value: .eight), LuckyCard(type: .Cat, value: .nine), LuckyCard(type: .Cat, value: .ten)])
    let deck2 = LuckyCardDeck(cards: [ LuckyCard(type: .Cow, value: .eight), LuckyCard(type: .Cat, value: .eleven)])
    let cardsOnField = [LuckyCard(type: .Dog, value: .eight)]
    
    var currentPlayer = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: []), id: currentUserName)
    var targetPlayer = LuckyCardGamePlayer(deck: LuckyCardDeck(cards: []), id: "D")
    
    let instruction = makeInstruction(for: deck1, for: deck2, cardsOnfield: cardsOnField)
    
    let mockController = makeMockGameProceedController(instruction: instruction, currentPlayer: currentPlayer, targetPlayer: targetPlayer, card: cardsOnField[0], field: field)
    
    //Gamestart이후에 CheckCard 실시Ga
    sut = LuckyCardDealer(deck: LuckyCardDeck(), gameProceedDelegate: mockController)
    sut.gameStart(with: [currentPlayer, targetPlayer], on: field)
    
    //when
    //then
    XCTAssertTrue(try sut.checkCards(with: "D", fieldCardIndex: 0))
    
  }
  
}

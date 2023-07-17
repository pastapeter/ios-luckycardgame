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
  var players: [CardgamePlayerable]!
  
  override func setUpWithError() throws {
    
    var instruction = LuckyGameInstruction(cardsSplited: [], cardsOnField: [])
    var mockStrategy = mockGameStrategy(instruction: instruction)
    players = [0,1,2].map { LuckyCardGamePlayer(deck: LuckyCardDeck(cards: []), id: PlayerDataBase.currentPlayerName[$0])}
    field = LuckyGameField(deck: LuckyCardDeck(cards: []))
    mockGameProceedController = MockGameProceedController(gameStrategy: mockStrategy, players: players, field: field)
    
    sut = LuckyCardDealer(deck: LuckyCardDeck(), gameProceedDelegate: mockGameProceedController)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    field = nil
    players = nil
    mockGameProceedController = nil
  }
  
  // MARK: - Given Helper Function
  
  func makeInstruction(for currentPlayerDeck: LuckyCardDeck, for targetDeck: LuckyCardDeck, cardsOnfield: [LuckyCard]) -> LuckyGameInstruction {
    return LuckyGameInstruction(cardsSplited: [currentPlayerDeck, targetDeck], cardsOnField: cardsOnfield)
  }
  
  func makeMockGameProceedController(
    instruction: LuckyGameInstruction,
    players: [CardgamePlayerable],
    field: CardGameBoardComponent
  ) -> MockGameProceedController {
    return MockGameProceedController(
      gameStrategy: mockGameStrategy(instruction: instruction),
      players: players,
      field: field)
  }
  
  
  func test_gameStart를불렀을때_gameStrategy의instruction에맞게나눠지는지() throws {
   
    //given
    
    var deck1 = LuckyCardDeck(cards: [LuckyCard(type: .Cat, value: .two)])
    var deck2 = LuckyCardDeck(cards: [LuckyCard(type: .Cat, value: .three)])
    var deck3 = LuckyCardDeck(cards: [LuckyCard(type: .Cat, value: .four)])
    var cardsOnField : [LuckyCard] = [LuckyCard(type: .Cat, value: .five)]
    
    let instruction = LuckyGameInstruction(cardsSplited: [deck1, deck2, deck3], cardsOnField: cardsOnField)
    
    //sut이 참조하고있는 mock
    let mock = makeMockGameProceedController(instruction: instruction,players: players, field: field)
    
    sut = LuckyCardDealer(deck: LuckyCardDeck(),
                          gameProceedDelegate: mock)

    //when
    sut.gameStart(with: mock.players, on: field)
    //then
    XCTAssertEqual(players[0].cards, deck1.cards)
    XCTAssertEqual(players[1].cards, deck2.cards)
    XCTAssertEqual(players[2].cards, deck3.cards)
    XCTAssertEqual(field.cards, cardsOnField)
    
    
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
  
  func test_checkCard를불렀을때_fieldCardIndex가_field카드수보다많으면_GameSystemError발생하는지() throws {
    //given
    let deck1 = LuckyCardDeck(cards: [ LuckyCard(type: .Cat, value: .eight), LuckyCard(type: .Cat, value: .nine), LuckyCard(type: .Cat, value: .ten)])
    let deck2 = LuckyCardDeck(cards: [ LuckyCard(type: .Cow, value: .eight), LuckyCard(type: .Cat, value: .eleven)])
    let deck3 = LuckyCardDeck(cards: [ LuckyCard(type: .Dog, value: .nine), LuckyCard(type: .Dog, value: .eleven)])
    let cardsOnField = [LuckyCard(type: .Dog, value: .eight)]

    let instruction = LuckyGameInstruction(cardsSplited: [deck1, deck2, deck3], cardsOnField: cardsOnField)

    let mockController = makeMockGameProceedController(instruction: instruction, players: players, field: field)

    //Gamestart이후에 CheckCard 실시Ga
    sut = LuckyCardDealer(deck: LuckyCardDeck(), gameProceedDelegate: mockController)
    sut.gameStart(with: players, on: field)

    //when
    //then
    let exp = GameProceedingError.GameSystemError
    XCTAssertThrowsError(try sut.checkCards(with: "B", fieldCardIndex: 1)) { error in
      XCTAssertEqual(exp, error as? GameProceedingError)
    }
  }
  
  
  func test_gameStart이후_checkCard를불렀을때_모두같은CardValue가있다면_True리턴하는지() {

    //given
    let deck1 = LuckyCardDeck(cards: [ LuckyCard(type: .Cat, value: .eight), LuckyCard(type: .Cat, value: .nine), LuckyCard(type: .Cat, value: .ten)])
    let deck2 = LuckyCardDeck(cards: [ LuckyCard(type: .Cow, value: .eight), LuckyCard(type: .Cat, value: .eleven)])
    let deck3 = LuckyCardDeck(cards: [ LuckyCard(type: .Dog, value: .nine), LuckyCard(type: .Dog, value: .eleven)])
    let cardsOnField = [LuckyCard(type: .Dog, value: .eight)]

    let instruction = LuckyGameInstruction(cardsSplited: [deck1, deck2, deck3], cardsOnField: cardsOnField)

    let mockController = makeMockGameProceedController(instruction: instruction, players: players, field: field)

    //Gamestart이후에 CheckCard 실시Ga
    sut = LuckyCardDealer(deck: LuckyCardDeck(), gameProceedDelegate: mockController)
    sut.gameStart(with: players, on: field)

    //when
    //then
    XCTAssertTrue(try sut.checkCards(with: "B", fieldCardIndex: 0))

  }
  
}

//
//  LuckyGameCardTests.swift
//  LuckyCardGameTests
//
//  Created by Jung peter on 7/13/23.
//

import XCTest
@testable import LuckyCardGame

/*
 바닥에 깔린 카드도 숫자 오름차순으로 정렬할 수 있어야 한다
 카드가 뒤집혔을때 확인이 가능한지
 */

final class LuckyGameCardTests: XCTestCase {
  
  var sut: LuckyCard!
  let emoji = CardEmojiType.Cat
  let value = CardValue.one
  let status = CardStatus.up
  
  override func setUpWithError() throws {
    sut = LuckyCard(type: emoji, value: value, status: status)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_카드끼리_value가다를때_다르다고인지하는지() {
    
    // given
    let input = LuckyCard(type: emoji, value: .eight)
    
    // when
    // then
    XCTAssertNotEqual(sut, input)
    
  }
  
  func test_카드끼리_emoji만다를때_다르다고인지하는지() {
    
    //given
    let input = LuckyCard(type: .Dog, value: value)
    
    //when
    //then
    XCTAssertNotEqual(sut, input)
    
  }
  
  
  func test_카드끼리_emoji랑value는같은데_status가다를때_같다고인지하는지() {
    
    //given
    let input = LuckyCard(type: emoji, value: value, status: .down)
    
    //when
    //then
    XCTAssertEqual(sut, input)
    
  }
  
  func test_카드끼리_value로_대소구분이가능한지() {
    //given
    guard let index = CardValue.allCases.firstIndex(of: value) else { return }
    guard let next = CardValue(rawValue: index) else { return }
    let input = LuckyCard(type: emoji, value:next, status: status)
    
    //when
    //then
    XCTAssertGreaterThan(sut, input)
  }
  
  func test_카드가_flip을부르면_status가바뀌는지() {
    //given
    let currentStatus = sut.status
    //when
    sut.flip()
    
    //then
    XCTAssertNotEqual(currentStatus, sut.status)
  }
  
}

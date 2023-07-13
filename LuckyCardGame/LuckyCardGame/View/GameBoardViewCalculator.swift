//
//  GameBoardViewCalculator.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/11/23.
//

import UIKit

struct GameBoardViewCalculator {
  
  private typealias Constant = GameBoardViewController.Constant
  
  static func calculateCardFramesInField(numberOfCards: Int, cardHeight: Int, boardHeight: Int) -> [CGRect] {
    // 더 클 때
    var cacheFrame = CGRect(x: Constant.horizontalPadding / 2, y: 0, width: Constant.cardWidth, height: cardHeight)
    var devidence = 1
    var numberOfCards = numberOfCards
    // 몇줄로 표현할것인지
    while Constant.horizontalPadding + (numberOfCards / devidence * Constant.cardWidth) > (Int(screenWidth) - Constant.horizontalPadding * 2) {
      devidence += 1
    }
    let verticalGap = (boardHeight - cardHeight * devidence) / (devidence+1)
    cacheFrame.origin.y += CGFloat(verticalGap)
    var cardInRow = Int(ceil(Double(numberOfCards) / Double(devidence)))
    
    // 한줄로 표현
    if cardInRow == numberOfCards {
      let spacing = abs(calculateOverrlappedWidth(numberOfCard: cardInRow))
      return (0..<numberOfCards).map { idx in
        let curFrame = cacheFrame
        cacheFrame.origin.x = CGFloat(Int(curFrame.origin.x) + Constant.cardWidth + spacing)
        return curFrame
      }
    } else {
      let spacing = abs(calculateOverrlappedWidth(numberOfCard: cardInRow))
      let firstFrame: CGRect = cacheFrame
      var cardFrames: [CGRect] = []
      while numberOfCards > 0 {
        let cardFramesInaRow = (0..<cardInRow).map { idx in
          let curFrame = cacheFrame
          cacheFrame.origin.x = CGFloat(Int(curFrame.origin.x) + Constant.cardWidth + spacing)
          return curFrame
        }
        cardFrames += cardFramesInaRow
        numberOfCards -= cardInRow
        cardInRow = numberOfCards
        cacheFrame = firstFrame
        cacheFrame.origin.y += CGFloat(cardHeight + verticalGap)
      }
      return cardFrames
    }
  }
  
  //Board의 카드 Frame 계산한다.
  static func calculateCardFrameInPlayerBoard(by index: Int, overlappedWidth: Int, height: Int) -> CGRect {
    return CGRect(
      x: index*Int((Constant.cardWidth - overlappedWidth)) + Constant.horizontalPadding / 2,
      y: Constant.cardPadding / 2,
      width: Int(GameBoardViewController.Constant.cardWidth),
      height: height - Constant.cardPadding)
  }
  
  // BoardView의 Height을 계산한다.
  static func calculateViewHeight(start: Int, numberOfBoardNeeded: Int) -> (playerBoardHeight: Int, bottomDockViewHeight: Int, cardHeight: Int) {
    var needed = numberOfBoardNeeded
    if numberOfBoardNeeded == 3 { needed = 4 }
    let y = Int(screenHeight) - (Constant.topPadding + Constant.bottomPadding + Constant.topBoardHeight + ((needed+1)*Constant.spacing) + needed*start)
    if numberOfBoardNeeded >= 5 {
      if y > start { return calculateViewHeight(start: start+1, numberOfBoardNeeded: needed) }
      else { return (y, start, y - Constant.cardPadding)}
    } else {
      if y > start*2 { return calculateViewHeight(start: start+1, numberOfBoardNeeded: needed) }
      else { return (start, y, start - Constant.cardPadding)}
    }
  }
  
  // 카드의 Overlap된 영역 계산
  static func calculateOverrlappedWidth(numberOfCard: Int) -> Int {
    let playerBoardWidth = Int(screenWidth) - (3*Constant.horizontalPadding)
    return (Constant.cardWidth * (numberOfCard) - playerBoardWidth) / (numberOfCard-1)
  }
  
  // BottomDockView에 대한 Frame 계산
  static func calculateBottomDockViewFrame(from lastFrame: CGRect, height: Int) -> CGRect {
    return CGRect(x: Constant.horizontalPadding,
                  y:Int(lastFrame.origin.y + lastFrame.height) + Constant.spacing,
                  width: Int(screenWidth) - Constant.horizontalPadding * 2,
                  height: height)
  }
  
  // playerBoard에 대한 Frame 계산
  static func calculatePlayerBoard(by index: Int, height: Int) -> CGRect {
    return CGRect(x: Constant.horizontalPadding,
                  y: Constant.topPadding + Constant.topBoardHeight + Constant.spacing * (index+1) + height * index,
                  width: Int(screenWidth) - Constant.horizontalPadding*2,
                  height: height)
  }
  
}

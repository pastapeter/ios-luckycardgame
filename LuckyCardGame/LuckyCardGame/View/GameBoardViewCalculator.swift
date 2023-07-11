//
//  GameBoardViewCalculator.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/11/23.
//

import UIKit

struct GameBoardViewCalculator {
  
  private typealias Constant = GameBoardViewController.Constant
  
  static func calculateCardFramesInField(numberOfCards: Int, cardHeight: Int) -> [CGRect] {
    // 더 클 때
    var cacheFrame = CGRect(x: Constant.horizontalPadding / 2, y: 0, width: Constant.cardWidth, height: cardHeight)
    if Constant.horizontalPadding + (numberOfCards * Constant.cardWidth) > (Int(screenHeight) - Constant.horizontalPadding * 2) {
        return []
    }
    let spacing = abs(calculateOverrlappedWidth(numberOfCard: numberOfCards))
    return (0..<numberOfCards).map { idx in
      let curFrame = cacheFrame
      cacheFrame.origin.x = CGFloat(Int(curFrame.origin.x) + Constant.cardWidth + spacing)
      return curFrame
    }
  }
  
  //Board의 카드 Frame 계산한다.
  static func calculateCardFrame(by index: Int, overlappedWidth: Int, height: Int) -> CGRect {
    return CGRect(
      x: index*Int((Constant.cardWidth - overlappedWidth)) + Constant.horizontalPadding / 2,
      y: 0,
      width: Int(GameBoardViewController.Constant.cardWidth),
      height: height - 10)
  }
  
  // BoardView의 Height을 계산한다.
  static func calculateBoardHeight(start: Int, numberOfBoardNeeded: Int) -> (playerBoardHeight: Int, bottomDockViewHeight: Int) {
    var needed = numberOfBoardNeeded
    if numberOfBoardNeeded == 3 { needed = 4 }
    let y = Int(screenHeight) - (Constant.topPadding + Constant.bottomPadding + Constant.topBoardHeight + ((needed+1)*Constant.spacing) + needed*start)
    if numberOfBoardNeeded >= 5 {
      if y > start { return calculateBoardHeight(start: start+1, numberOfBoardNeeded: needed) }
      else { return (y, start )}
    } else {
      if y > start*2 { return calculateBoardHeight(start: start+1, numberOfBoardNeeded: needed) }
      else { return (start, y)}
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

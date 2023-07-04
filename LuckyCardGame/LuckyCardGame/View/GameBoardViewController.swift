//
//  GameBoardViewController.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/4/23.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

final class GameBoardViewController: UIViewController {
  
  struct Constant {
    static let topBoardHeight = 44
    static let horizontalPadding = 20
    static let topPadding = 70
    static let bottomPadding = 20
    static let spacing = 10
  }
  
  private var playerBoardHeight = 0
  private var bottomDockViewHeight = 0
  
  private var topBoard: RoundBoardView = {
    let topboard = RoundBoardView(frame: CGRect(x: Constant.horizontalPadding, y: Constant.topPadding, width: Int(screenWidth) - Constant.horizontalPadding * 2, height: Constant.topBoardHeight))
    topboard.backgroundColor = .yellow
    return topboard
  }()
  
  private lazy var playerBoards: [PlayerboardView] = {

    let boards = ["A", "B", "C", "D", "E"].enumerated().map { i, name in
      return PlayerboardView(frame: CGRect(
        x: Constant.horizontalPadding,
        y: Constant.topPadding + Constant.topBoardHeight + Constant.spacing * (i+1) + playerBoardHeight * i,
        width: Int(screenWidth) - Constant.horizontalPadding*2,
        height: playerBoardHeight), name: name)
    }
    return boards
  }()
  
  private lazy var bottomDockView: RoundBoardView = {
    let lastBoardFrame = playerBoards[playerBoards.count - 1].frame
    let view = RoundBoardView(frame: CGRect(
      x: Constant.horizontalPadding,
      y: Int(lastBoardFrame.origin.y + lastBoardFrame.height) + Constant.spacing,
      width: Int(screenWidth) - Constant.horizontalPadding * 2,
      height: bottomDockViewHeight))
    view.backgroundColor = .gray
    return view
  }()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemBackground
      arrangeDynamicHeight()
      addsubview()
    }
  
  func addsubview() {
    let views = [topBoard, bottomDockView] + playerBoards
    views.forEach {
      self.view.addSubview($0)
    }
  }
  
  private func arrangeDynamicHeight() {
    let dynamicHeight = calculateBoardHeight(start: 0)
    playerBoardHeight = dynamicHeight.0
    bottomDockViewHeight = dynamicHeight.1
  }
  
  private func calculateBoardHeight(start: Int) -> (Int, Int) {
    let y = Int(screenHeight) - (Constant.topPadding + Constant.bottomPadding + Constant.topBoardHeight + (6*Constant.spacing) + 5*start)
    if y <= start {
      return (y, start)
    }
    return calculateBoardHeight(start: start+1)
  }
    
}

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
  
  enum Constant {
    static let topBoardHeight = 44
    static let horizontalPadding = 20
    static let topPadding = 70
    static let bottomPadding = 50
    static let spacing = 10
    static let cardWidth = (Int(screenWidth) - (3*horizontalPadding)) / 6
  }
  
  private var playerBoardHeight = 0
  private var bottomDockViewHeight = 0
  private var viewModel: GameBoardViewModel
  
  private lazy var gamePlayerSegmentControl: UISegmentedControl = {
    var segmentControl = UISegmentedControl(items: viewModel.gameType.map { "\($0.rawValue)명"})
    segmentControl.frame = CGRect(x: Constant.horizontalPadding, y: Constant.topPadding, width: Int(screenWidth) - Constant.horizontalPadding * 2, height: Constant.topBoardHeight)
    return segmentControl
  }()
  
  private let playerBoards: [PlayerboardView] = {
    let boards = PlayerDataBase.currentPlayerName.enumerated().map { i, name in
      return PlayerboardView(frame: .zero, name: name)
    }
    return boards
  }()
  
  private let bottomDockView: RoundCardBoardView = {
    let view = RoundCardBoardView(frame: .zero, radius: 16)
    view.backgroundColor = .gray
    return view
  }()
  
  init(viewModel: GameBoardViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    bind()
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = GameBoardViewModel(game: LuckyCardGame(numberOfPlayer:currentPlayerCount))
    super.init(coder: coder)
    bind()
  }
  
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemBackground
      setgameBoard()
      addsubview()
      configureGameSegmentControl()
      viewModel.startGame()
    }
  
  private func addsubview() {
    let views = [gamePlayerSegmentControl, bottomDockView] + playerBoards
    views.forEach {
      self.view.addSubview($0)
    }
  }
  
  func bind() {
    
    viewModel.didStartGame = { [weak self] game in
      guard let self else { return }
      
      game.players.enumerated().forEach { index, player in
        let cardviews = self.makeCardViews(to: player)
        self.playerBoards[index].addCardViews(with: cardviews)
      }
      
      let fieldCardViews = self.makeCardViews(to: game.field)
      self.bottomDockView.addCardViews(with: fieldCardViews)
    }
    
    viewModel.clearGame = { [weak self] in
      self?.playerBoards.forEach {
        $0.removeAllCardView()
      }
    }
    
    viewModel.didChangeNumberOfPlayer = { [weak self] game in
      guard let self else { return }
      self.setgameBoard()
      game.players.enumerated().forEach { index, player in
        let cardviews = self.makeCardViews(to: player)
        self.playerBoards[index].addCardViews(with: cardviews)
      }
      
      let fieldCardViews = self.makeCardViews(to: game.field)
      self.bottomDockView.addCardViews(with: fieldCardViews)
    }
    
  }
    
}

// MARK: - private Method
extension GameBoardViewController {
  
  private func setgameBoard() {
    (playerBoardHeight, bottomDockViewHeight) = GameBoardViewCalculator.calculateBoardHeight(start: 0, numberOfBoardNeeded: viewModel.numberOfPlayers)
    setupBoardHidden()
    arrangePlayerBoardViewFrame()
    arrangeBottomDockViewFrame()
  }
  
  private func setupBoardHidden() {
    playerBoards.forEach { $0.isHidden = false }
    for board in playerBoards[viewModel.numberOfPlayers...] {
      board.isHidden = true
    }
  }
  
  private func arrangePlayerBoardViewFrame() {
    self.playerBoards[..<viewModel.numberOfPlayers].enumerated().forEach {
      $1.frame = GameBoardViewCalculator.calculatePlayerBoard(by: $0, height: self.playerBoardHeight)
    }
  }
  
  private func arrangeBottomDockViewFrame() {
    self.bottomDockView.frame = GameBoardViewCalculator.calculateBottomDockViewFrame(from: lastPlayerBoardFrame(), height: self.bottomDockViewHeight)

  }
  
  private func lastPlayerBoardFrame() -> CGRect {
    var lastBoardBottomOriginFrame = playerBoards[viewModel.numberOfPlayers - 1].frame
    if viewModel.numberOfPlayers == 3 {
      lastBoardBottomOriginFrame = playerBoards[viewModel.numberOfPlayers].frame
    }
    return lastBoardBottomOriginFrame
  }
  
  private func configureGameSegmentControl() {
    gamePlayerSegmentControl.selectedSegmentIndex = viewModel.gameType.firstIndex(of: currentPlayerCount) ?? 0
    let action = UIAction { [weak self] _ in
      guard let self else { return }
      self.viewModel.changeNumberOfPlayer(by: self.viewModel.gameType[gamePlayerSegmentControl.selectedSegmentIndex])
    }
    gamePlayerSegmentControl.addAction(action, for: .valueChanged)
  }
  
  private func makeCardViews(to cardReceivable: some CardReceivable) -> [CardView] {
    let overlappedWidth = GameBoardViewCalculator.calculateOverrlappedWidth(numberOfCard: cardReceivable.deck.cards.count)
    var cardviews: [CardView] = []
    
    if cardReceivable is LuckyCardGamePlayer {
      
      cardviews = cardReceivable.deck.cards.enumerated().map {
        let cardView = CardView(frame: GameBoardViewCalculator.calculateCardFrame(by: $0,                                          overlappedWidth: overlappedWidth, height: self.playerBoardHeight)
        )
        if $1.status == .up { cardView.flip() }
        return cardView
      }
      
    } else if cardReceivable is LuckyGameField {
      let frames = GameBoardViewCalculator.calculateCardFramesInField(numberOfCards: cardReceivable.deck.cards.count, cardHeight: self.playerBoardHeight)
      cardviews = frames.map { CardView(frame: $0) }
      }
    return cardviews
  }
  
}



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
    static let cardPadding = 10
    static let topPadding = 70
    static let bottomPadding = 50
    static let spacing = 10
    static let cardWidth = (Int(screenWidth) - (3*horizontalPadding)) / 6
  }
  
  private var playerBoardHeight = 0
  private var bottomDockViewHeight = 0
  private var cardHeight = 0
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
    startGame()
  }
  
  private func addsubview() {
    let views = [gamePlayerSegmentControl, bottomDockView] + playerBoards
    views.forEach {
      self.view.addSubview($0)
    }
  }
  
  // MARK: - Bind
  
  func bind() {
    
    viewModel.didStartGame = { [weak self] game in
      guard let self else { return }
      self.updateGameUIWhenStart(game: game)
    }
    
    viewModel.clearGame = { [weak self] in
      self?.playerBoards.forEach {
        $0.removeAllCardView()
      }
      self?.bottomDockView.removeAllCardView()
    }
    
    viewModel.didChangeNumberOfPlayer = { [weak self] game in
      guard let self else { return }
      self.setgameBoard()
      self.updateGameUIWhenStart(game: game)
    }
    
  }
  
}

// MARK: - private Method
extension GameBoardViewController {
  
  private func updateGameUIWhenStart(game: Game) {
    game.players.enumerated().forEach { index, player in
      let cardviews = self.makeCardViews(to: player)
      self.playerBoards[index].addCardViews(with: cardviews)
    }
    
    let fieldCardViews = self.makeCardViews(to: game.field)
    self.bottomDockView.addCardViews(with: fieldCardViews)
  }
  
  private func startGame() {
    viewModel.startGame()
  }
  
  private func setgameBoard() {
    (playerBoardHeight, bottomDockViewHeight, cardHeight) = GameBoardViewCalculator.calculateViewHeight(start: 0, numberOfBoardNeeded: viewModel.numberOfPlayers)
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
      lastBoardBottomOriginFrame.origin.y += playerBoards[0].frame.height + CGFloat(Constant.spacing)
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
  
  private func makeCardViews(to receiver: some CardGameBoardComponent) -> [CardView] {
    let overlappedWidth = GameBoardViewCalculator.calculateOverrlappedWidth(numberOfCard: receiver.countCardsInDeck())
    var cardviews: [CardView] = []
    
    if receiver is LuckyCardGamePlayer {
      cardviews = receiver.cards.enumerated().map {
        let cardView = CardView(frame: GameBoardViewCalculator.calculateCardFrameInPlayerBoard(by: $0,                                          overlappedWidth: overlappedWidth, height: self.playerBoardHeight), cardInfo: $1
        )
        return cardView
      }
      
    } else if receiver is LuckyGameField {
      let frames = GameBoardViewCalculator.calculateCardFramesInField(numberOfCards: receiver.countCardsInDeck(), cardHeight: self.cardHeight, boardHeight: self.bottomDockViewHeight)
      return zip(receiver.cards, frames).map { card, frame in
        CardView(frame: frame, cardInfo: card)
      }
    }
    return cardviews
  }
  
}



//
//  CardView.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/10/23.
//

import UIKit

enum CardLabelLocation {
  case mid
  case left_top
  case right_bottom
  
  func origin(subviewFrame: CGRect, labelFrame: CGRect) -> CGPoint {
    switch self {
    case .mid:
      return CGPoint(x: (subviewFrame.width - labelFrame.width) / 2, y: (subviewFrame.height - labelFrame.height) / 2)
    case .left_top:
      return CGPoint(x: 3, y: 3)
    case .right_bottom:
      return CGPoint(x: subviewFrame.width - labelFrame.width - 3, y: subviewFrame.height - labelFrame.height - 3)
    }
  }
}

final class CardView: RoundView {
  
  private lazy var backView: UIView = {
    let backView = UIView(frame: self.bounds)
    let backImageView = UIImageView(image: UIImage(named: "lucky_card_back"))
    backImageView.contentMode = .scaleAspectFit
    backImageView.frame = backView.bounds
    backView.addSubview(backImageView)
    return backView
  }()
  
  private lazy var topValueLabel = makeCardViewLabel(location: .left_top, text: "\(cardInfo.value.rawValue)")
  private lazy var bottomValueLabel = makeCardViewLabel(location: .right_bottom, text: "\(cardInfo.value.rawValue)")
  private lazy var emojiLabel = makeCardViewLabel(location: .mid, text: cardInfo.type.emojiUnicode)
  
  private var cardInfo: any Card
  
  init(frame: CGRect, radius: Int, cardInfo: any Card) {
    self.cardInfo = cardInfo
    super.init(frame: frame, radius: radius)
    setupCardView()
  }
  
  convenience init(frame: CGRect, cardInfo: any Card) {
    self.init(frame: frame, radius: 16, cardInfo: cardInfo)
  }
  
  required init?(coder: NSCoder, radius: Int, cardInfo: any Card) {
    self.cardInfo = cardInfo
    super.init(coder: coder, radius: radius)
    setupCardView()
  }
  
  convenience required init?(coder: NSCoder) {
    self.init(coder: coder, radius: 16)
  }
  
  required init?(coder: NSCoder, radius: Int) {
    self.cardInfo = LuckyCard(type: .Cat, value: .one)
    super.init(coder: coder, radius: radius)
    setupCardView()
  }
  
  func flip() {
    self.backView.isHidden = !self.backView.isHidden
    [topValueLabel, bottomValueLabel, emojiLabel].forEach {
      $0.isHidden = !$0.isHidden
    }
  }
  
}

extension CardView {
  
  private func setupCardView() {
    setFrontView()
    setBackgroundColor()
    setupBackView()
    setupBorder()
  }
  
  private func setFrontView() {
    [topValueLabel, emojiLabel, bottomValueLabel].forEach {  self.addSubview($0) }
    if cardInfo.status == .down {
      [topValueLabel, emojiLabel, bottomValueLabel].forEach { $0.isHidden = true }
    }
  }
  
  private func makeCardViewLabel(location: CardLabelLocation, text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.sizeToFit()
    label.frame.origin = location.origin(subviewFrame: self.frame, labelFrame: label.frame)
    return label
  }
  
  private func setBackgroundColor() {
    self.backgroundColor = .white
  }
  
  private func setupBackView() {
    if cardInfo.status == .up { backView.isHidden = true }
    self.addSubview(backView)
  }
  
  private func setupBorder() {
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 1
  }
  
}


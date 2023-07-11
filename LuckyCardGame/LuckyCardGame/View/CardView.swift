//
//  CardView.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/10/23.
//

import UIKit

final class CardView: RoundCardBoardView {
  
  private lazy var backView: UIView = {
    let backView = UIView(frame: self.bounds)
    let backImageView = UIImageView(image: UIImage(named: "lucky_card_back"))
    backImageView.contentMode = .scaleAspectFit
    backImageView.frame = backView.bounds
    backView.addSubview(backImageView)
    return backView
  }()
  
  override init(frame: CGRect, radius: Int) {
    super.init(frame: frame, radius: radius)
    setBackgroundColor()
    addSubviews()
    setupBorder()
  }
  
  convenience required init?(coder: NSCoder) {
    self.init(coder: coder, radius: 16)
    setBackgroundColor()
    addSubviews()
    setupBorder()
  }
  
  required init?(coder: NSCoder, radius: Int) {
    super.init(coder: coder, radius: radius)
    setBackgroundColor()
    addSubviews()
    setupBorder()
  }
  
  func flip() {
    self.backView.isHidden = !self.backView.isHidden
  }
  
}

extension CardView {
  
  private func setBackgroundColor() {
    self.backgroundColor = .white
  }
  
  private func addSubviews() {
    self.addSubview(backView)
  }
  
  private func setupBorder() {
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 1
  }
  
}


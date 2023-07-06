//
//  RoundBoardView.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/4/23.
//

import UIKit

class RoundBoardView: UIView {
  
  convenience init(frame: CGRect, radius: Int = 16) {
    self.init(frame: frame)
    setRound(radius: radius)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func setRound(radius: Int) {
    self.layer.cornerRadius = CGFloat(radius)
    self.layer.masksToBounds = true
  }
  
}

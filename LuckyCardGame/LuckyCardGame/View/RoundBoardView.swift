//
//  RoundBoardView.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/4/23.
//

import UIKit

class RoundBoardView: UIView {
  
  init(frame: CGRect, radius: Int) {
    super.init(frame: frame)
    setRound(radius: radius)
  }
  
  required init?(coder: NSCoder, radius: Int) {
    super.init(coder: coder)
    setRound(radius: radius)
  }
  
  convenience override init(frame: CGRect) {
    self.init(frame: frame, radius: 16)
  }
  
  convenience required init?(coder: NSCoder) {
    self.init(coder: coder, radius: 16)
  }
  
  func setRound(radius: Int) {
    self.layer.cornerRadius = CGFloat(radius)
    self.layer.masksToBounds = true
  }
  
}

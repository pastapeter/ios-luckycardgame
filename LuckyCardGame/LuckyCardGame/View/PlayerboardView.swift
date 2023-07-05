//
//  PlayerboardView.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/4/23.
//

import UIKit

class PlayerboardView: RoundBoardView {

  private lazy var playerNameLabel: UILabel = {
    
    let label = UILabel()
    label.text = "A"
    label.textColor = .gray.withAlphaComponent(0.5)
    let descriptor = UIFont.systemFont(ofSize: 50, weight: .heavy).fontDescriptor
                .withSymbolicTraits([.traitBold, .traitItalic])
    label.font = UIFont(descriptor: descriptor!, size: 50)
    return label
  }()
  
  convenience init(frame: CGRect, name: String) {
    self.init(frame: frame, radius: 16)
    playerNameLabel.text = name
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addsubview()
    configureView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    addsubview()
    configureView()
  }
  
  private func configureView() {
    backgroundColor = .systemGray5
  }
  
  private func addsubview() {
    self.addSubview(playerNameLabel)
    playerNameLabel.sizeToFit()
    playerNameLabel.frame = CGRect(x: 10, y: 0, width: playerNameLabel.frame.width, height: self.frame.height)
  }
  

}

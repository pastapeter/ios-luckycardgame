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
    let descriptor = UIFont.systemFont(ofSize: 50).fontDescriptor
                .withSymbolicTraits([.traitBold, .traitItalic])
    label.font = UIFont(descriptor: descriptor!, size: 50)
    return label
  }()
  
  init(frame: CGRect, name: String) {
    super.init(frame: frame)
    playerNameLabel.text = name
    addsubview()
    configureView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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

//
//  PlayerboardView.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/4/23.
//

import UIKit

final class PlayerboardView: RoundCardBoardView {

  private lazy var playerNameLabel: UILabel = {
    let label = UILabel()
    label.text = "A"
    label.textColor = .gray.withAlphaComponent(0.5)
    let descriptor = UIFont.systemFont(ofSize: 50, weight: .heavy).fontDescriptor
                .withSymbolicTraits([.traitBold, .traitItalic])
    label.font = UIFont(descriptor: descriptor!, size: 50)
    return label
  }()
  
  init(frame: CGRect, radius: Int, name: String) {
    super.init(frame: frame, radius: 16)
    playerNameLabel.text = name
    addsubview()
    configureView()
  }
  
  convenience init(frame: CGRect, name: String) {
    self.init(frame: frame, radius: 16, name: name)
  }
  
  required init?(coder: NSCoder, radius: Int, name: String) {
    super.init(coder: coder, radius: radius)
    playerNameLabel.text = name
    addsubview()
    configureView()
  }
  
  required init?(coder: NSCoder, radius: Int) {
    super.init(coder: coder, radius: radius)
    playerNameLabel.text = ""
    addsubview()
    configureView()
  }
  
  convenience required init?(coder: NSCoder, name: String) {
    self.init(coder: coder, radius: 16, name: name)
  }
  
  convenience required init?(coder: NSCoder) {
    self.init(coder: coder, radius: 16, name: "A")
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

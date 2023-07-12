//
//  CardRemovable.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/12/23.
//

import UIKit

protocol CardRemovable: UIView {
  func removeAllCardView()
}

extension CardRemovable {
  func removeAllCardView() {
    for subview in subviews {
      if subview is CardView {
        subview.removeFromSuperview()
      }
    }
  }
}

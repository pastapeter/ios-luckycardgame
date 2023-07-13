//
//  File.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/12/23.
//

import UIKit

protocol CardAddable: UIView {
  func addCardViews(with cardViews: [CardView])
}

extension CardAddable {
  func addCardViews(with cardViews: [CardView]) {
    cardViews.forEach { self.addSubview($0) }
  }
}

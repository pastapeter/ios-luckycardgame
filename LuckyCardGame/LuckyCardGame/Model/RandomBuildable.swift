//
//  Buildable.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

protocol RandomBuildable {
  associatedtype T
  static func makeRandomly() -> T
}

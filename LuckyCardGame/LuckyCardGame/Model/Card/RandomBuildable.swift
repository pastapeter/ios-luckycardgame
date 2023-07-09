//
//  Buildable.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

protocol Buildable {
  associatedtype T
  static func make() -> T
}

protocol RandomBuildable: Buildable {
  static func makeRandomly() -> T
}

//
//  NumberValidator.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/5/23.
//

import Foundation

enum CardValidationTypeError: LocalizedError {
  case unavailableType
}

enum NumberValidationError: LocalizedError {
  case notInOneToTweleve
  
  var errorDescription: String? {
    switch self {
    case .notInOneToTweleve:
      return "1...12 사이의 숫자가 아닙니다"
    }
  }
}

enum StringValidationError: LocalizedError {
  case notKQJ
  
  var errorDescription: String? {
    switch self {
    case .notKQJ:
      return "K, Q, J 알파벳이 아닙니다."
    }
  }
  
}

struct CardValueValidator {
  
  static func isvalid(_ cardValue: Int) throws {
    try isvalidNumber(cardValue)
  }
  
  static func isvalidString(_ string: String) throws {
    if ["K", "Q", "Z"].contains(string) == false {
      throw StringValidationError.notKQJ
    }
  }
  
  static func isvalidNumber(_ num: Int) throws {
    if CardValue(rawValue: num) == nil {
      throw NumberValidationError.notInOneToTweleve
    }
  }
}

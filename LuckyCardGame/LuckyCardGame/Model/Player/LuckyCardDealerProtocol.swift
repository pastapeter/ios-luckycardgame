//
//  LuckyCardDealerProtocol.swift
//  LuckyCardGame
//
//  Created by Jung peter on 7/16/23.
//

import Foundation

protocol LuckyCardDealerProtocol: CardSplitable, CardReceivable {
  func gameStart(with players: [CardgamePlayerable], on field: CardGameBoardComponent)
  func checkCards(with targetPlayerId: String, fieldCardIndex: Int) throws -> Bool
  func setDelegateForProceedGame(with delegate: GameProceedDelegate)
}

//
//  SquareInfo.swift
//  FischerUI
//
//  Created by Omar Megdadi on 11/4/25.
//

import FischerCore
import Foundation

public struct SquareInfo: Identifiable {
    public var id: String
    public var piece: Piece?
    public var square: Square
}

public struct MoveInfo: Identifiable {
    public let id: UUID = UUID()
    let turn: UInt
    let sanMove: SANMove
    let playerColor: PlayerColor
    let nag: NAG?
}

extension MoveInfo: CustomStringConvertible {
    public var description: String {
        switch self.playerColor {
            case .white:
            return "\(self.turn). \(self.sanMove) \(self.nag?.symbol ?? "")"
            case .black:
            return "\(self.sanMove)"
        }
    }
}

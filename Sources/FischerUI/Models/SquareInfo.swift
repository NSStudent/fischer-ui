//
//  SquareInfo.swift
//  FischerUI
//
//  Created by Omar Megdadi on 11/4/25.
//

import FischerCore

public struct SquareInfo: Identifiable {
    public var id: String
    public var piece: Piece?
    public var square: Square
}

public struct MoveInfo {
    let turn: UInt
    let sanMove: SANMove
    let playerColor: PlayerColor
    let nag: NAG?
}

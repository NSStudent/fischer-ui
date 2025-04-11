//
//  PGNElement+MoveInfo.swift
//  FischerUI
//
//  Created by Omar Megdadi on 11/4/25.
//
import FischerCore
extension PGNElement {
    func moveInfo(for playerColor: PlayerColor) -> MoveInfo? {
        guard let move = move(for: playerColor) else { return nil }
        return MoveInfo(turn: turn, sanMove: move, playerColor: playerColor, nag: nag(for: playerColor))
    }
    
    func move(for playerColor: PlayerColor) -> SANMove? {
        switch playerColor {
        case .white:
            return whiteMove
        case .black:
            return blackMove
        }
    }
    
    func nag(for playerColor: PlayerColor) -> NAG? {
        switch playerColor {
        case .white:
            return whiteEvaluation?.first
        case .black:
            return blackEvaluation?.first
        }
    }
}

//
//  PieceTheme.swift
//  FischerUI
//
//  Created by Omar Megdadi on 5/4/25.
//
import FischerCore
enum PieceTheme: String {
    case cburnett
    case merida
    case rhosgfx
    
    func imageName(for piece: Piece) -> String {
        let colorString = piece.color.isWhite() ? "w" : "b"
        let pieceStringCapitalized = piece.fenName.capitalized
        return "\(self.rawValue)_\(colorString)\(pieceStringCapitalized)"
    }
}

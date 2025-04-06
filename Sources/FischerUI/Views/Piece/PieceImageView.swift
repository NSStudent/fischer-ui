//
//  PieceImageView.swift
//  FischerUI
//
//  Created by Omar Megdadi on 6/4/25.
//
import FischerCore
import SwiftUI

public struct PieceImageView: View {
    let piece: Piece
    let pieceTheme: PieceTheme
    
    public init(piece: Piece, pieceTheme: PieceTheme) {
        self.piece = piece
        self.pieceTheme = pieceTheme
    }
    
    
    var imageName: String {
        pieceTheme.imageName(for: piece)
    }
    
    public var body: some View {
        Image(imageName, bundle: Bundle.module)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview(traits: .fixedLayout(width: 100, height: 100)) {
    PieceImageView(piece: .init(knight: .black), pieceTheme: .rhosgfx)
}

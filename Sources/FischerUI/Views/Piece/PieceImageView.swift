//
//  PieceImageView.swift
//  FischerUI
//
//  Created by Omar Megdadi on 6/4/25.
//
import FischerCore
import SwiftUI

struct PieceImageView: View {
    let piece: Piece
    let pieceTheme: PieceTheme
    
    var imageName: String {
        pieceTheme.imageName(for: piece)
    }
    
    var body: some View {
        Image(imageName, bundle: Bundle.module)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview(traits: .fixedLayout(width: 100, height: 100)) {
    PieceImageView(piece: .init(knight: .black), pieceTheme: .rhosgfx)
}

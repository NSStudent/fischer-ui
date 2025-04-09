//
//  BoardBackgroundViewModel.swift
//  FischerUI
//
//  Created by Omar Megdadi on 9/4/25.
//

import Foundation

@Observable
class BoardBackgroundViewModel {
    var orientation: Orientation
    var boardTheme: BoardTheme
    var pieceTheme: PieceTheme
    
    init(
        orientation: Orientation,
        boardTheme: BoardTheme,
        pieceTheme: PieceTheme
    ) {
        self.orientation = orientation
        self.boardTheme = boardTheme
        self.pieceTheme = pieceTheme
    }
}

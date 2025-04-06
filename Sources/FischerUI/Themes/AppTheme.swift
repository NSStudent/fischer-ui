//
//  AppTheme.swift
//  FischerUI
//
//  Created by Omar Megdadi on 29/3/25.
//

import SwiftUI

public struct AppTheme {
    public let pieceTheme: PieceTheme
    public let boardTheme: BoardTheme
    
    public init(
        pieceTheme: PieceTheme,
        boardTheme: BoardTheme
    ) {
        self.pieceTheme = pieceTheme
        self.boardTheme = boardTheme
    }
    
    @MainActor public static let `default` = AppTheme(pieceTheme: .cburnett, boardTheme: .green)
}

//
//  AppTheme.swift
//  FischerUI
//
//  Created by Omar Megdadi on 29/3/25.
//

import SwiftUI

struct AppTheme {
    let pieceTheme: PieceTheme
    let boardTheme: BoardTheme
}

struct BoardTheme {
    let ligthColor: Color
    let darkColor: Color
}

enum PieceTheme {
    case merida
    case cBrunnett
}

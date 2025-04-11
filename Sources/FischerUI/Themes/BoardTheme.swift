//
//  BoardTheme.swift
//  FischerUI
//
//  Created by Omar Megdadi on 5/4/25.
//

import FischerCore
import SwiftUI

public struct BoardTheme {
    let ligthColor: Color
    let darkColor: Color
    let highlightColor: Color
    let isCoordinatesVisible: Bool
    
    init(
        ligthColor: Color,
        darkColor: Color,
        highlightColor: Color = .yellow,
        isCoordinatesVisible: Bool = true
    ) {
        self.ligthColor = ligthColor
        self.darkColor = darkColor
        self.highlightColor = highlightColor
        self.isCoordinatesVisible = isCoordinatesVisible
    }
    
    @MainActor public static let brown: BoardTheme = .init(ligthColor: .brownLight, darkColor: .brownDark)
    @MainActor public static let green: BoardTheme = .init(ligthColor: .greenLight, darkColor: .greenDark)
    @MainActor public static let rhosgfx: BoardTheme = .init(ligthColor: .rhosgfxLight, darkColor: .rhosgfxDark)
    @MainActor public static let take: BoardTheme = .init(ligthColor: .takeLight, darkColor: .takeDark)
    
    public func color(for square: Square) -> Color {
        square.color == .dark ? self.darkColor : self.ligthColor
    }
    
    public func opositeColor(for square: Square) -> Color {
        square.color == .dark ? self.ligthColor : self.darkColor
    }
}

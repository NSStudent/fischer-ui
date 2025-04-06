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
    let isCoordinatesVisible: Bool
    
    @MainActor public static let brown: BoardTheme = .init(ligthColor: .brownLight, darkColor: .brownDark, isCoordinatesVisible: true)
    @MainActor public static let green: BoardTheme = .init(ligthColor: .greenLight, darkColor: .greenDark, isCoordinatesVisible: true)
    @MainActor public static let rhosgf: BoardTheme = .init(ligthColor: .rhosgfxLight, darkColor: .rhosgfxDark, isCoordinatesVisible: true)
    
    public func color(for square: Square) -> Color {
        square.color == .dark ? self.darkColor : self.ligthColor
    }
    
    public func opositeColor(for square: Square) -> Color {
        square.color == .dark ? self.ligthColor : self.darkColor
    }
}

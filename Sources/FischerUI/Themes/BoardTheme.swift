//
//  BoardTheme.swift
//  FischerUI
//
//  Created by Omar Megdadi on 5/4/25.
//

import SwiftUI

public struct BoardTheme {
    let ligthColor: Color
    let darkColor: Color
    
    @MainActor public static let brown: BoardTheme = .init(ligthColor: .brownLight, darkColor: .brownDark)
    @MainActor public static let green: BoardTheme = .init(ligthColor: .greenLight, darkColor: .greenDark)
    @MainActor public static let rhosgf: BoardTheme = .init(ligthColor: .rhosgfxLight, darkColor: .rhosgfxDark)
    
}

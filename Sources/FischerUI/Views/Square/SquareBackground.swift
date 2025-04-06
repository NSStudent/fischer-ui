//
//  SquareBackground.swift
//  FischerUI
//
//  Created by Omar Megdadi on 6/4/25.
//

import SwiftUI
import FischerCore

public struct SquareBackground: View {
    let square: Square
    let theme: BoardTheme
    
    public init(
        square: Square,
        theme: BoardTheme,
    ) {
        self.square = square
        self.theme = theme
    }
    
    public var body: some View {
        Rectangle()
            .fill(color(for: square))
            .aspectRatio(1, contentMode: .fill)
    }
    
    public func color(for square: Square) -> Color {
        square.color == .dark ? theme.darkColor : theme.ligthColor
    }
}

#Preview(traits: .fixedLayout(width: 100, height: 100)) {
    SquareBackground(square: .a2, theme: BoardTheme.brown)
}

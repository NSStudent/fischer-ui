//
//  SquareBackground.swift
//  FischerUI
//
//  Created by Omar Megdadi on 6/4/25.
//

import SwiftUI
import FischerCore

public struct SquareBackground: View {
    let theme: BoardTheme
    let square: Square
    
    public init(
        theme: BoardTheme,
        square: Square
    ) {
        self.theme = theme
        self.square = square
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
    SquareBackground(theme: BoardTheme.brown, square: .a2)
}

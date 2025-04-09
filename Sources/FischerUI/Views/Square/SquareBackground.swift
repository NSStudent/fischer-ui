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
    let orientation: Orientation
    
    public init(
        square: Square,
        theme: BoardTheme,
        orientation: Orientation
    ) {
        self.square = square
        self.theme = theme
        self.orientation = orientation
    }
    
    public var body: some View {
        Rectangle()
            .fill(theme.color(for: square))
            .aspectRatio(1, contentMode: .fill)
            .if(shouldShowFileAnnotation(square)) { view in
                view.modifier(SquareFileAnnotation(square: square, theme: theme))
            }
            .if(shouldShowRankAnnotation(square)) { view in
                view.modifier(SquareRankAnnotation(square: square, theme: theme))
            }
    }
    
    public func shouldShowFileAnnotation(_ square: Square) -> Bool {
        let rankAnnotiation: Rank = orientation.isblack() ? .eight : .one
        guard theme.isCoordinatesVisible && square.rank == rankAnnotiation else { return false }
        return true
    }
    
    public func shouldShowRankAnnotation(_ square: Square) -> Bool {
        let fileAnntation: File = orientation.isblack() ? .h : .a
        guard theme.isCoordinatesVisible && square.file == fileAnntation else { return false }
        return true
    }
}

#Preview(traits: .fixedLayout(width: 100, height: 100)) {
    SquareBackground(square: .a2, theme: BoardTheme.brown, orientation: .whiteSite)
}

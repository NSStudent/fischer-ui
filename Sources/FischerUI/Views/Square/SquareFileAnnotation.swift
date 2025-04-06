//
//  SquareFileAnnotation.swift
//  FischerUI
//
//  Created by Omar Megdadi on 6/4/25.
//

import SwiftUI
import FischerCore

struct SquareFileAnnotation: ViewModifier {
    let square: Square
    let theme: BoardTheme
    let margin: CGFloat = 5
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottomTrailing) {
                Text(square.file.description)
                    .font(.footnote)
                    .foregroundStyle(theme.opositeColor(for: square))
                    .padding(.bottom, margin)
                    .padding(.trailing, margin)
            }
    }
}



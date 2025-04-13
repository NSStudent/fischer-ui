//
//  Square+Grid.swift
//  FischerUI
//
//  Created by Omar Megdadi on 9/4/25.
//

import FischerCore

extension Square {
    @MainActor static func gridCollection(with orientation: Orientation) -> [Square] {
        switch orientation {
        case .whiteSide:
            return Square.gridCollection
        case .blackSide:
            return Square.flippedGridCollection
        }
    }
    
    @MainActor static var flippedGridCollection: [Square] =  [
        .h1, .g1, .f1, .e1, .d1, .c1, .b1, .a1,
        .h2, .g2, .f2, .e2, .d2, .c2, .b2, .a2,
        .h3, .g3, .f3, .e3, .d3, .c3, .b3, .a3,
        .h4, .g4, .f4, .e4, .d4, .c4, .b4, .a4,
        .h5, .g5, .f5, .e5, .d5, .c5, .b5, .a5,
        .h6, .g6, .f6, .e6, .d6, .c6, .b6, .a6,
        .h7, .g7, .f7, .e7, .d7, .c7, .b7, .a7,
        .h8, .g8, .f8, .e8, .d8, .c8, .b8, .a8
    ]
    
    @MainActor static let gridCollection: [Square] = { return [
        .a8, .b8, .c8, .d8, .e8, .f8, .g8, .h8,
        .a7, .b7, .c7, .d7, .e7, .f7, .g7, .h7,
        .a6, .b6, .c6, .d6, .e6, .f6, .g6, .h6,
        .a5, .b5, .c5, .d5, .e5, .f5, .g5, .h5,
        .a4, .b4, .c4, .d4, .e4, .f4, .g4, .h4,
        .a3, .b3, .c3, .d3, .e3, .f3, .g3, .h3,
        .a2, .b2, .c2, .d2, .e2, .f2, .g2, .h2,
        .a1, .b1, .c1, .d1, .e1, .f1, .g1, .h1
        ]
    }()
}

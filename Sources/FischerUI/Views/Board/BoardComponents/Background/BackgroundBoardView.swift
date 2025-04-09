//
//  BackgroundBoardView.swift
//  FischerUI
//
//  Created by Omar Megdadi on 9/4/25.
//

import SwiftUI
import FischerCore

struct BoardBackgroundView: View {
    var viewModel: BoardBackgroundViewModel
    public let columns: [GridItem] = .init(repeating: .chessFile, count: 8)
        
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(Square.gridCollection(with: viewModel.orientation)) { square in
                SquareBackground(square: square, theme: viewModel.boardTheme, orientation: viewModel.orientation)
            }
        }
    }
}

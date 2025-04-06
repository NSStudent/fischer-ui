//
//  ContentView.swift
//  ShowCaseApp
//
//  Created by Omar Megdadi on 29/3/25.
//

import SwiftUI
import FischerUI

struct ContentView: View {
    let appTheme: AppTheme = .default
    var body: some View {
        VStack {
            Image(systemName: "square.grid.3x3.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello FischerUI, version \(Constants.version)")
            ZStack {
                SquareBackground(square: .a2, theme: appTheme.boardTheme)
            
                PieceImageView(piece: .init(knight: .black), pieceTheme: appTheme.pieceTheme)
            }
            .frame(width: 50, height: 50)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

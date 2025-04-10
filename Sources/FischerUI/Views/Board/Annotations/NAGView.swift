//
//  NAGView.swift
//  FischerUI
//
//  Created by Megdadi, Omar on 10/4/25.
//

import SwiftUI
import FischerCore

struct NAGView: View {
    let nagSymbol: String
    let color: Color
    let square: Square
    let orientation: Orientation
    let squareSize: CGFloat
    var body: some View {
        Text(nagSymbol)
            .font(.headline)
            .minimumScaleFactor(0.5)
            .foregroundColor(.white)
            .frame(width: squareSize / 2, height: squareSize / 2)
            .background(
                Circle()
                    .fill(color)
                    .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
            )
            .position(nagPoint(square: square, orientation: orientation, squareSize: squareSize))
    }

    func nagPoint(
        square: Square,
        orientation: Orientation,
        squareSize: CGFloat
    ) -> CGPoint {
        let isOnTop = orientation.isblack() ? square.rank == 1 : square.rank == 8
        let isOnRight = orientation.isblack() ? square.file == .a : square.file == .h
        let deltaX = isOnRight ? squareSize / 4 : squareSize / 2
        let deltaY = isOnTop ? squareSize / 4 : squareSize / 2
        let deltaYOriented = orientation.isblack() ? deltaY : -deltaY
        let initialPoint = square.offset(orientation: orientation, squareSize: squareSize)
        return CGPoint(x: initialPoint.x + deltaX, y: initialPoint.y + deltaYOriented)
    }
}


#Preview(traits: .fixedLayout(width: 400, height: 400)) {
    ZStack {
        BoardView()
        NAGView(
            nagSymbol: "!!",
            color: .green,
            square: .c4,
            orientation: .whiteSide,
            squareSize: 50
        )

        NAGView(
            nagSymbol: "??",
            color: .red,
            square: .b8,
            orientation: .whiteSide,
            squareSize: 50
        )

        NAGView(
            nagSymbol: "?!",
            color: .orange,
            square: .h8,
            orientation: .whiteSide,
            squareSize: 50
        )

        NAGView(
            nagSymbol: "?!",
            color: .orange,
            square: .h2,
            orientation: .whiteSide,
            squareSize: 50
        )

        ArrowView(fromSquare: .f1, toSquare: .c4, orientation: .whiteSide, squareSize: 50, color: .orange)
        ArrowView(fromSquare: .b8, toSquare: .c6, orientation: .whiteSide, squareSize: 50, color: .purple)
    }
}

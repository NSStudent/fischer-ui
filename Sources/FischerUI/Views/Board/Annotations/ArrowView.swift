//
//  ArrowView.swift
//  FischerUI
//
//  Created by Omar Megdadi on 9/4/25.
//

import SwiftUI
import FischerCore

struct ArrowView: View {
    let fromSquare: Square
    let toSquare: Square
    let orientation: Orientation
    let squareSize: CGFloat
    let color: Color
    let strokeWidth: CGFloat?
    
    var body: some View {
        let startPoint = fromSquare.offset(orientation: orientation, squareSize: squareSize)
        let endPoint = toSquare.offset(orientation: orientation, squareSize: squareSize)
        let arrowAngle = CGFloat(Double.pi / 5)
        
        let rankDistance = toSquare.rank.index - fromSquare.rank.index
        let fileDistance = toSquare.file.index - fromSquare.file.index
        let isKnightMove = (abs(rankDistance) == 2 && abs(fileDistance) == 1) || (abs(rankDistance) == 1 && abs(fileDistance) == 2)
        
        Path { path in
            var delta: CGPoint
            path.move(to: startPoint)
            
            if isKnightMove {
                let dx = endPoint.x - startPoint.x
                let dy = endPoint.y - startPoint.y
                let horizontalFirst = abs(dx) > abs(dy)
                let turnPoint = horizontalFirst ? CGPoint(x: endPoint.x, y: startPoint.y) : CGPoint(x: startPoint.x, y: endPoint.y)
                path.addLine(to: turnPoint)
                delta = CGPoint(
                    x: endPoint.x - turnPoint.x,
                    y: endPoint.y - turnPoint.y
                )
            } else {
                delta = CGPoint(
                    x: endPoint.x - startPoint.x,
                    y: endPoint.y - startPoint.y
                )
            }
            
            // Draw Triangle
            let pointerLineLength = squareSize * 0.15625
            let angle = atan2(delta.y, delta.x)
            let arrowLine1 = CGPoint(
                x: endPoint.x + pointerLineLength * cos(CGFloat(Double.pi) - angle + arrowAngle),
                y: endPoint.y - pointerLineLength * sin(CGFloat(Double.pi) - angle + arrowAngle)
            )
            let arrowLine2 = CGPoint(
                x: endPoint.x + pointerLineLength * cos(CGFloat(Double.pi) - angle - arrowAngle),
                y: endPoint.y - pointerLineLength * sin(CGFloat(Double.pi) - angle - arrowAngle)
            )
            
            let triangleCenter = ((arrowLine1.x + endPoint.x + arrowLine2.x)/3, (arrowLine1.y + endPoint.y + arrowLine2.y)/3)
            path.addLine(to: CGPoint(x: triangleCenter.0, y: triangleCenter.1))
            path.move(to: arrowLine1)
            path.addLine(to: endPoint)
            path.addLine(to: arrowLine2)
            path.closeSubpath()
        }
        .strokedPath(StrokeStyle(lineWidth: strokeWidth ?? squareSize * 0.15625, lineCap: .round, lineJoin: .miter))
        .foregroundColor(color)
    }
}

#Preview(traits: .fixedLayout(width: 400, height: 400)) {
    ZStack {
        BoardView()
        ArrowView(fromSquare: .b1, toSquare: .c3, orientation: .whiteSide, squareSize: 50, color: .orange, strokeWidth: nil)
    }
}


extension Square {
    func offset(orientation: Orientation, squareSize: CGFloat) -> CGPoint {
        let halfSquareSize = squareSize / 2
        switch orientation {
            case .whiteSide:
            return CGPoint(x: CGFloat(self.file.index) * squareSize + halfSquareSize , y: CGFloat(self.rank.opposite().index) * squareSize + halfSquareSize )
            case .blackSide:
            return CGPoint(x: CGFloat(self.file.opposite().index) * squareSize + halfSquareSize , y:  CGFloat(self.rank.index) * squareSize + halfSquareSize )
        }
    }
}

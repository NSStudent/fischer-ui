//
//  BoardView.swift
//  FischerUI
//
//  Created by Omar Megdadi on 6/4/25.
//

import FischerCore
import SwiftUI

public struct BoardView: View {
    @State var isFlipped: Bool = false
    @State var draggedPiece: Piece? = nil
    @State var dragOffset: CGSize = CGSizeZero
    @State var initialSquare: Square? = nil
    @State var toSquare: Square? = nil
    let boardTheme: BoardTheme = .green
    let pieceTheme: PieceTheme = .cburnett
    let game = try! Game.init(position: Game.Position(fen: "r2qkbnr/ppp2ppp/2np4/4p3/2B1P1b1/2N2N2/PPPP1PPP/R1BQK2R w KQkq - 2 5")!)
    public let columns: [GridItem] = .init(repeating: .chessFile, count: 8)
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .center) {
            ZStack {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(currentGridCollection()) { square in
                        ZStack {
                            SquareBackground(square: square, theme: boardTheme, isFlipped: isFlipped)
                        }
                    }
                }
                
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(currentGridCollection()) { square in
                        if let currentPiece = piece(in: square)  {
                            PieceImageView(piece: currentPiece, pieceTheme: pieceTheme)
                                .offset(isDraggedPiece(currentPiece, square: square) ? dragOffset : CGSizeZero)
                                .opacity(isDraggedPiece(currentPiece, square: square) ? 0 : 1)
                                .zIndex(isDraggedFrom(square: square) ? 100 : 0)
                                .gesture(
                                    DragGesture()
                                        .onChanged({ gesture in
                                            draggedPiece = currentPiece
                                            initialSquare = square
                                            dragOffset = gesture.translation
                                        })
                                        .onEnded({ gesture in
                                            draggedPiece = nil
                                            initialSquare = nil
                                            dragOffset = .zero
                                        })
                                )
                        } else {
                            Rectangle().fill(Color.clear)
                        }
                    }
                }
                
                if let draggedPiece, let square = initialSquare,
                   let index = currentGridCollection().firstIndex(of: square) {
                    GeometryReader { geo in
                        let _ = print(geo.size)
                        let min = min(geo.size.width, geo.size.height)
                        let gridSize = geo.size
                        let squareSize = min / 8
                        let row = index / 8
                        let col = index % 8
                        let x = CGFloat(col) * squareSize
                        let y = CGFloat(row) * squareSize
                        
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.2))
                                .scaleEffect(1.3)
                            PieceImageView(piece: draggedPiece, pieceTheme: pieceTheme)
                        }
                        .frame(width: squareSize, height: squareSize)
//                        .scaleEffect(1.3)
                        .position(x: x + squareSize / 2, y: y )
                        .offset(dragOffset)
                        .zIndex(999)
                    }
                }
            }
            
//            Button {
//                isFlipped.toggle()
//            } label: {
//                Text("flip")
//            }

        }
    }
    
    func isDraggedPiece(_ piece: Piece, square: Square) -> Bool {
        piece.fenName == draggedPiece?.fenName && square == initialSquare
    }
    
    func isDraggedFrom(square: Square) -> Bool {
        square == initialSquare
    }
    
    func piece(in square: Square) -> Piece?{
        
        game.board[square]
    }
    
    func currentGridCollection() -> [Square] {
        isFlipped ? Square.flippedGridCollection : Square.gridCollection
    }
}

#Preview(traits: .fixedLayout(width: 500, height: 500)){
    BoardView()
}


extension Square {
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
}

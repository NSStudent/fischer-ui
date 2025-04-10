//
//  BoardView.swift
//  FischerUI
//
//  Created by Omar Megdadi on 6/4/25.
//

import FischerCore
import SwiftUI

@Observable
@MainActor
class BoardViewModel {
    var orientation: Orientation = .whiteSide
    var draggedPiece: Piece? = nil
    var dragOffset: CGSize = CGSizeZero
    var initialSquare: Square? = nil
    var isDragging: Bool = false
    var finalSquare: Square? = nil {
        didSet {
            if let initialSquare, let finalSquare {
                try? game.execute(move: initialSquare >>> finalSquare)
            }
        }
    }
    var boardTheme: BoardTheme = .take
    var pieceTheme: PieceTheme = .cburnett
    var game = try! Game.init(position: Game.Position(fen: "r2qkbnr/ppp2ppp/2np4/4p3/2B1P1b1/2N2N2/PPPP1PPP/R1BQK2R w KQkq - 2 5")!)
}

public struct BoardView: View {
    @State var viewModel = BoardViewModel()
    public let columns: [GridItem] = .init(repeating: .chessFile, count: 8)
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .center) {
            GeometryReader { geo in
                let side = min(geo.size.width, geo.size.height)
                ZStack {
                    background()
                    piecesView(with: geo)
                    draggedPieceView()
                }
                .frame(width: side, height: side)
            }
//            Button("Flip") {
//                viewModel.orientation.toggle()
//                viewModel.boardTheme = [.green, .brown, .rhosgfx].randomElement() ?? .green
//                viewModel.pieceTheme = [.merida, .cburnett, .rhosgfx].randomElement() ?? .merida
//            }
        }
    }
    
    @ViewBuilder
    func background() -> some View {
        BoardBackgroundView(
            viewModel: BoardBackgroundViewModel(
                orientation: viewModel.orientation,
                boardTheme: viewModel.boardTheme,
                pieceTheme: viewModel.pieceTheme
            )
        )
    }
    
    func piecesView(with geometry: GeometryProxy) -> some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(Square.gridCollection(with: viewModel.orientation)) { square in
                if let currentPiece = piece(in: square)  {
                    PieceImageView(piece: currentPiece, pieceTheme: viewModel.pieceTheme)
                        .offset(isDraggedPiece(currentPiece, square: square) ? viewModel.dragOffset : CGSizeZero)
                        .opacity(isDraggedPiece(currentPiece, square: square) && viewModel.isDragging ? 0 : 1)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    viewModel.isDragging = true
                                    viewModel.draggedPiece = currentPiece
                                    viewModel.initialSquare = square
                                    viewModel.dragOffset = gesture.translation
                                    
                                })
                                .onEnded({ gesture in
                                    viewModel.isDragging = false
                                    viewModel.finalSquare = calculateDraggedSquare(with: geometry, offset: gesture.translation)
                                    withAnimation(.spring()) {
                                        viewModel.draggedPiece = nil
                                        viewModel.initialSquare = nil
                                        viewModel.dragOffset = .zero
                                    }
                                })
                        )
                } else {
                    Rectangle().fill(Color.clear)
                        .frame(width: squareWidth(in: geometry), height: squareWidth(in: geometry))
                }
            }
        }
    }
    
    @ViewBuilder
    func draggedPieceView() -> some View {
        if let draggedPiece = viewModel.draggedPiece, let square = viewModel.initialSquare,
           let index = Square.gridCollection(with: viewModel.orientation).firstIndex(of: square) {
            GeometryReader { geo in
                let min = min(geo.size.width, geo.size.height)
                let squareSize = min / 8
                let row = index / 8
                let col = index % 8
                let x = CGFloat(col) * squareSize
                let y = CGFloat(row) * squareSize
                
                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.2))
                        .scaleEffect(1.3)
                    PieceImageView(piece: draggedPiece, pieceTheme: viewModel.pieceTheme)
                }
                .frame(width: squareSize, height: squareSize)
                .scaleEffect(1.5)
                .position(x: x + squareSize / 2, y: y + squareSize / 2)
                .offset(viewModel.dragOffset)
                .zIndex(999)
            }
        }
    }
    
    func isDraggedPiece(_ piece: Piece, square: Square) -> Bool {
        piece.fenName == viewModel.draggedPiece?.fenName && square == viewModel.initialSquare
    }
    
    func isDraggedFrom(square: Square) -> Bool {
        square == viewModel.initialSquare
    }
    
    func piece(in square: Square) -> Piece?{
        viewModel.game.board[square]
    }
    
    func calculateDraggedSquare(with geometry: GeometryProxy, offset: CGSize) -> Square? {
        guard let initialSquare = viewModel.initialSquare else { return nil }
        let boardSize = min(geometry.size.width, geometry.size.height)
        let squareSize = Int(boardSize / 8)
        let orientation = viewModel.orientation.isblack() ? -1 : 1
        let deltaX = orientation * Int(offset.width) / squareSize
        let deltaY = orientation * Int(offset.height) / squareSize
        

        let toSquareRank = Rank(rawValue: max(min(8, initialSquare.rank.rawValue - deltaY), 1))
        let toSquareFile = File(rawValue: max(min(8, initialSquare.file.rawValue + deltaX), 1))

        guard let rank = toSquareRank, let file = toSquareFile else { return nil }
        return Square(file: file, rank: rank)
    }
    
    func squareWidth(in geometry: GeometryProxy) -> CGFloat {
        let min = min(geometry.size.width, geometry.size.height)
        let squareSize = min / 8
        return squareSize
    }
}

#Preview(traits: .fixedLayout(width: 500, height: 500)){
    BoardView()
}

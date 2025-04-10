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
    var game = Game()
    var pgnGame: PGNGame = PGNGame.mock
    var movements: [SANMove] = []
    var index = 0
    
    func didLoad() throws {
        if let fen = pgnGame.fen(), let position = Game.Position(fen: fen) {
            game = try Game(position: position)
        }
        
        movements = pgnGame.elements.map{ element in
            [element.whiteMove, element.blackMove]
        }.flatMap{$0}.compactMap{$0}
    }
    
    func next() {
        guard movements.count > index else { return }
        let currentSanMove = movements[index]
        guard let move = try? Move(board: game.board, sanMove: currentSanMove, turn: index % 2 == 0 ? .white : .black) else {
            return
        }
        print("""
        SAN: \(currentSanMove.description)
        Move: \(move.description)
        """
        )
        try? game.execute(move: move)
        index += 1
    }
    
    func undoMove() {
        guard let move = game.undoMove() else { return }
        print("""
        undo Move: \(move.description)
        """)
        index -= 1
    }
    
    func pieceInfo() -> [SquareInfo] {
        let b: [Square] = Square.allCases
        let c = b.map { square in
            let id = game.token.token[square.rawValue]
            return SquareInfo(id: id, piece: game.board[square], square: square)
        }
        return c
    }
}

public struct SquareInfo: Identifiable {
    public var id: String
    public var piece: Piece?
    public var square: Square
}

public struct BoardView: View {
    @State var viewModel = BoardViewModel()
    public let columns: [GridItem] = .init(repeating: .chessFile, count: 8)
    
    public init() {}
    
    public var body: some View {
        VStack {
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
            }
            
            Button("Flip") {
                viewModel.orientation.toggle()
                viewModel.boardTheme = [.green, .brown, .rhosgfx].randomElement() ?? .green
                viewModel.pieceTheme = [.merida, .cburnett, .rhosgfx].randomElement() ?? .merida
            }
            Button("next Move") {
                withAnimation(.snappy) {
                    viewModel.next()
                }
            }
            
            Button("undo Move") {
                withAnimation(.smooth) {
                    viewModel.undoMove()
                }
            }
            
        }
        .onAppear {
            try? viewModel.didLoad()
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
    
    @ViewBuilder
    func piecesView(with geometry: GeometryProxy) -> some View {
        let pieceInfoArray = viewModel.pieceInfo()
        let squareSize = squareWidth(in: geometry)
        ForEach(pieceInfoArray) { pieceInfo in
            let position = pieceInfo.square.offset(orientation: viewModel.orientation, squareSize: squareSize)
            if let piece = pieceInfo.piece {
                PieceImageView(piece: piece, pieceTheme: viewModel.pieceTheme)
                    .frame(width: squareSize, height: squareSize)
                    .position(position)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: squareSize, height: squareSize)
                    .position(position)
            }
            
        }
    }
    
//    func piecesView(with geometry: GeometryProxy) -> some View {
//        LazyVGrid(columns: columns, spacing: 0) {
//            ForEach(Square.gridCollection(with: viewModel.orientation)) { square in
//                if let currentPiece = piece(in: square)  {
//                    PieceImageView(piece: currentPiece, pieceTheme: viewModel.pieceTheme)
//                        .offset(isDraggedPiece(currentPiece, square: square) ? viewModel.dragOffset : CGSizeZero)
//                        .opacity(isDraggedPiece(currentPiece, square: square) && viewModel.isDragging ? 0 : 1)
//                        .gesture(
//                            DragGesture()
//                                .onChanged({ gesture in
//                                    viewModel.isDragging = true
//                                    viewModel.draggedPiece = currentPiece
//                                    viewModel.initialSquare = square
//                                    viewModel.dragOffset = gesture.translation
//                                    
//                                })
//                                .onEnded({ gesture in
//                                    viewModel.isDragging = false
//                                    viewModel.finalSquare = calculateDraggedSquare(with: geometry, offset: gesture.translation)
//                                    withAnimation(.spring()) {
//                                        viewModel.draggedPiece = nil
//                                        viewModel.initialSquare = nil
//                                        viewModel.dragOffset = .zero
//                                    }
//                                })
//                        )
//                } else {
//                    Rectangle().fill(Color.clear)
//                        .frame(width: squareWidth(in: geometry), height: squareWidth(in: geometry))
//                }
//            }
//        }
//    }
    
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

//
//  BoardView.swift
//  FischerUI
//
//  Created by Omar Megdadi on 6/4/25.
//

import FischerCore
import SwiftUI

public struct BoardView: View {
    @State var viewModel = BoardViewModel()
    public let columns: [GridItem] = .init(repeating: .chessFile, count: 8)
    
    public init() {}
    
    public var body: some View {
        VStack {
            boardView()
            controllersView()
            sanGrid()
            Spacer()
        }
        .onAppear {
            try? viewModel.didLoad()
        }
    }
    
    @ViewBuilder
    func sanGrid() -> some View {
        let columns = [
            GridItem(.flexible(minimum: 40, maximum: 200)),
            GridItem(.flexible(minimum: 40, maximum: 200))
        ]
        
        ScrollViewReader { proxy in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    if viewModel.moveInfoList.first?.playerColor == .black {
                        Text("...")
                    }
                    ForEach(Array(viewModel.moveInfoList.enumerated()), id: \.element.id) { index, item in
                        Text(item.description)
//                            .foregroundColor(nagForegorundColor(item))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background {
                                if index == viewModel.index - 1 {
                                    viewModel.boardTheme.highlightColor
                                } else {
                                    Color.clear
                                }
                            }
//                            .id(index)
                            .onTapGesture {
                                viewModel.moveToIndex(index)
                            }// ← importante para hacer scroll
                    }
                }
                .padding(.horizontal)
            }
            .onChange(of: viewModel.index) { newIndex in
                withAnimation {
                    proxy.scrollTo(newIndex - 1, anchor: .center) // desplazamos al movimiento activo
                }
            }
            .frame(maxHeight: 300)
        }
    }
    
    func nagForegorundColor(item: MoveInfo) -> Color? {
        if let nag = item.nag, !nag.symbol.isEmpty {
            return nag.color
        } else {
            return nil
        }
    }
    
    @ViewBuilder
    func boardView() -> some View {
        GeometryReader { geo in
            let side = min(geo.size.width, geo.size.height)
            ZStack {
                background()
                    .animation(nil, value: viewModel.orientation)
                lastMoveHighlithed(with: geo)
                    .animation(nil, value: viewModel.game.board)
                    .animation(nil, value: viewModel.orientation)
                piecesView(with: geo)
                lastMoveArrowView(with: geo)
                draggedPieceView()
                nagView(with: geo)
            }
            .frame(width: side, height: side)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    @ViewBuilder
    func controllersView() -> some View {
        HStack {
            
            Button {
                withAnimation(.snappy) {
                    viewModel.orientation.toggle()
                }
            } label: {
                Image(systemName: "arrow.2.squarepath")
            }

            Spacer()

            Button {
                withAnimation(.smooth) {
                    viewModel.undoGame()
                }
            } label: {
                Image(systemName: "chevron.left.2")
            }

            Spacer()

            Button {
                withAnimation(.snappy(duration: 0.3)) {
                    viewModel.undoMove()
                }
            } label: {
                Image(systemName: "chevron.left")
            }

            Spacer()

            Button {
                withAnimation(.snappy(duration: 0.3)) {
                    viewModel.next()
                }
            } label: {
                Image(systemName: "chevron.right")
            }

            Spacer()

            Button {
                withAnimation(.snappy(duration: 0.3)) {
                    viewModel.lastMove()
                }
            } label: {
                Image(systemName: "chevron.right.2")
            }

            Spacer()

            Button {
                viewModel.boardTheme = [.green, .brown, .rhosgfx].randomElement() ?? .green
                viewModel.pieceTheme = [.merida, .cburnett, .rhosgfx].randomElement() ?? .merida
            } label: {
                Image(systemName: "paintpalette")
            }
            
            Spacer()
            
            Button {
                testFen()
            } label: {
                Image(systemName: "document.on.clipboard")
            }
        }
        .buttonStyle(.bordered)
        .padding()
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
        let squareSize = geometry.squareWidth()
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
    
    @ViewBuilder
    func nagView(with geometry: GeometryProxy) -> some View {
        let squareSize = geometry.squareWidth()
        if let currentNag = viewModel.currentNag,
           !currentNag.symbol.isEmpty,
           let square = viewModel.game.moveHistory.last?.move.end{
            NAGView(
                nagSymbol: currentNag.symbol,
                color: currentNag.color,
                square: square,
                orientation: viewModel.orientation,
                squareSize: squareSize
            )
            .id(UUID())
        }
    }
    
    @ViewBuilder
    func lastMoveArrowView(with geometry: GeometryProxy) -> some View {
        let squareSize = geometry.squareWidth()
        if let lastMove = viewModel.game.moveHistory.last?.move
        {
            ArrowView(fromSquare: lastMove.start, toSquare: lastMove.end, orientation: viewModel.orientation, squareSize: squareSize, color: .black, strokeWidth: 2)
        }
    }


    @ViewBuilder
    func lastMoveHighlithed(with geometry: GeometryProxy) -> some View {
        let squareSize = geometry.squareWidth()
        if let lastMove = viewModel.game.moveHistory.last?.move
        {
            HightlightSquare(color: viewModel.boardTheme.highlightColor)
                .frame(width: squareSize, height: squareSize)
                .position(lastMove.start.offset(orientation: viewModel.orientation, squareSize: squareSize))
            HightlightSquare(color: .yellow)
                .frame(width: squareSize, height: squareSize)
                .position(lastMove.end.offset(orientation: viewModel.orientation, squareSize: squareSize))
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
    
    public func testFen() {
        if let copyString = ClipboardHelper.paste(),
           let pgn = try? PGNGameParser().parse(copyString) {
            viewModel.pgnGame = pgn
            try? viewModel.didLoad()
            return
        }
    }
    
    
}

#Preview(traits: .fixedLayout(width: 500, height: 500)){
    BoardView()
}

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

public class ClipboardHelper {
    
    public static func copy(text: String) {
        #if canImport(UIKit)
        UIPasteboard.general.string = text
        #elseif canImport(AppKit)
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
        #endif
    }

    public static func paste() -> String? {
        #if canImport(UIKit)
        return UIPasteboard.general.string
        #elseif canImport(AppKit)
        let pasteboard = NSPasteboard.general
        return pasteboard.string(forType: .string)
        #else
        return nil
        #endif
    }
}

//
//  BoardViewModel.swift
//  FischerUI
//
//  Created by Omar Megdadi on 11/4/25.
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
    var pgnGame: PGNGame = PGNGame.mockNag
    var moveInfoList: [MoveInfo] = []
    var currentNag: NAG?
    var index = 0
    
    func didLoad() throws {
        if let fen = pgnGame.fen(), let position = Game.Position(fen: fen) {
            game = try Game(position: position)
        }
        
        moveInfoList = pgnGame.elements
            .map { element in
                let whiteMoveInfo = element.moveInfo(for: .white)
                let blackmoveInfo = element.moveInfo(for: .black)
                return [whiteMoveInfo, blackmoveInfo]
            }
            .flatMap{$0}
            .compactMap{$0}
        
//        movements = pgnGame.elements.map{ element in
//            [element.whiteMove, element.blackMove]
//        }.flatMap{$0}.compactMap{$0}
//        
//        nags = pgnGame.elements.map{ element in
//            [element.whiteEvaluation?.first, element.blackEvaluation?.first]
//        }.flatMap{$0}
//        
//        print(nags)
    }
    
    func next() {
        guard moveInfoList.count > index else { return }
        let currentSanMove = moveInfoList[index].sanMove
        guard let move = try? Move(board: game.board, sanMove: currentSanMove, turn: moveInfoList[index].playerColor) else {
            return
        }
        print("""
        SAN: \(currentSanMove.description)
        Move: \(move.description)
        """
        )
        
        currentNag = moveInfoList[index].nag
        try? game.execute(move: move)
        index += 1
    }
    
    func undoMove() {
        guard let move = game.undoMove() else { return }
        print("""
        undo Move: \(move.description)
        """)
        index -= 1
        currentNag = game.moveHistory.count > 0 ? moveInfoList[game.moveHistory.count - 1].nag : nil
    }

    func undoGame() {
        for _ in 0..<game.moveCount {
            let _ = game.undoMove()
        }
        index = 0
        currentNag = nil
    }

    func forwardGame() {
        for _ in 1...game.moveCount {
            let _ = game.undoMove()
        }
        index = 0
        currentNag = nil
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

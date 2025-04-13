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
    var pgnGame: PGNGame = PGNGame.mockFen
    var moveInfoList: [MoveInfo] = []
    var currentNag: NAG?
    var index = 0
    
    func didLoad() throws {
        if let fen = pgnGame.fen(), let position = Position(fen: fen) {
            game = try Game(position: position)
        } else {
            game = Game()
        }
        
        moveInfoList = pgnGame.elements
            .map { element in
                let whiteMoveInfo = element.moveInfo(for: .white)
                let blackmoveInfo = element.moveInfo(for: .black)
                return [whiteMoveInfo, blackmoveInfo]
            }
            .flatMap{$0}
            .compactMap{$0}
        
        index = 0
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
        
        var promotionKind: Piece.Kind = .queen
        switch currentSanMove {
        case .san(let sanDefaultMove):
            promotionKind = sanDefaultMove.promotionTo?.kind ?? .queen
        case .kingsideCastling, .queensideCastling:
            break
        }
        
        currentNag = moveInfoList[index].nag
        
        try? game.execute(move: move, promotion: promotionKind)
        index += 1
    }
    
    func moveToIndex(_ selectedIndex: Int) {
        forwardGame()
        moveTo(selectedIndex+1)
    }
    
    func lastMove() {
        for i in index..<moveInfoList.count {
            guard moveInfoList.count > i else { return }
            let currentSanMove = moveInfoList[i].sanMove
            guard let move = try? Move(board: game.board, sanMove: currentSanMove, turn: moveInfoList[i].playerColor) else {
                return
            }
            print("""
            SAN: \(currentSanMove.description)
            Move: \(move.description)
            """
            )
            
            currentNag = moveInfoList[i].nag
            try? game.execute(move: move)
        }
        index = game.moveCount
    }
    
    func moveTo(_ selectedIndex: Int) {
        for i in index..<selectedIndex {
            guard moveInfoList.count > i else { return }
            let currentSanMove = moveInfoList[i].sanMove
            guard let move = try? Move(board: game.board, sanMove: currentSanMove, turn: moveInfoList[i].playerColor) else {
                return
            }
            print("""
            SAN: \(currentSanMove.description)
            Move: \(move.description)
            """
            )
            
            currentNag = moveInfoList[i].nag
            try? game.execute(move: move)
        }
        index = game.moveCount
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
        guard game.moveCount > 0 else { return }
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

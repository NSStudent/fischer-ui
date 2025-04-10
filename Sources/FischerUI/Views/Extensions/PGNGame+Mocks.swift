//
//  PGNGame+Mocks.swift
//  FischerUI
//
//  Created by Omar Megdadi on 10/4/25.
//

import FischerCore

extension PGNGame {
    @MainActor static let mock: PGNGame = {
        let input =
        """
        [Event "Fighting against London: Bishop Kicking!"]
        [Site "https://lichess.org/study/Q7v33IGE/7W2bZKD5"]
        [Result "*"]
        [Variant "Standard"]
        [ECO "A45"]
        [Opening "Indian Defense"]
        [Annotator "https://lichess.org/@/delta_horsey"]
        [StudyName "Fighting against London"]
        [ChapterName "Bishop Kicking!"]
        [UTCDate "2025.03.24"]
        [UTCTime "00:41:42"]
        
        1. d4 Nf6 2. Bf4 b6!? (2... d5 3. e3 c5 4. c3 Nc6 5. Nd2 e6 6. Ngf3 Bd6 7. Bg3 O-O 8. Bd3) 3. e3 Bb7 4. Nf3 Nh5! 5. Bg5 (5. Bg3 Nxg3 6. hxg3 g6 7. c4 Bg7 8. Nc3 O-O 9. Bd3 e6 $36 10. Be4?! d5! 11. cxd5 exd5 12. Bd3 c5 $15) 5... h6 6. Bh4 g5 7. Nfd2 (7. Ne5 Nf6 8. Bg3 d6 9. Nc4 Ne4!? $13) (7. Bg3 Nxg3 8. hxg3 Bg7 9. Nbd2 e6 10. c3 d5 11. a4 a6! $10) 7... Nf4! 8. exf4 gxh4 9. Nf3 (9. Qh5?! e6 10. Nc3 Qf6! 11. Qe5 Qxe5+ 12. dxe5 Nc6 13. O-O-O O-O-O 14. Rg1 d6 $36) (9. h3? e6 10. Nc3 Qf6! $17) 9... e6 10. Nbd2 c5! 11. dxc5 bxc5 12. g3 Be7 13. Bg2 Nc6 $13 *
        """
        
        let parser = PGNGameParser()
        let result = try! parser.parse(input)
        return result
    }()
}

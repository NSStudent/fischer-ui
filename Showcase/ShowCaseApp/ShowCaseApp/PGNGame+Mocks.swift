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
        
        1. d4 $ Nf6 2. Bf4 b6!? (2... d5 3. e3 c5 4. c3 Nc6 5. Nd2 e6 6. Ngf3 Bd6 7. Bg3 O-O 8. Bd3) 3. e3 Bb7 4. Nf3 Nh5! 5. Bg5 (5. Bg3 Nxg3 6. hxg3 g6 7. c4 Bg7 8. Nc3 O-O 9. Bd3 e6 $36 10. Be4?! d5! 11. cxd5 exd5 12. Bd3 c5 $15) 5... h6 6. Bh4 g5 7. Nfd2 (7. $ Ne5 Nf6 8. Bg3 d6 9. Nc4 Ne4!? $13) (7. Bg3 Nxg3 8. hxg3 Bg7 9. Nbd2 e6 10. c3 d5 11. a4 a6! $10) 7... Nf4! 8. exf4 gxh4 9. Nf3 (9. Qh5?! e6 10. Nc3 Qf6! 11. Qe5 Qxe5+ 12. dxe5 Nc6 13. O-O-O O-O-O 14. Rg1 d6 $36) (9. h3? e6 10. Nc3 Qf6! $17) 9... e6 10. Nbd2 c5! 11. dxc5 bxc5 12. g3 Be7 13. Bg2 Nc6 $13 *
        """
        
        let parser = PGNGameParser()
        let result = try! parser.parse(input)
        return result
    }()
    
    @MainActor static let mockNag: PGNGame = {
        let input =
        """
        [Event "NAG Full Test"]
        [Site "Local"]
        [Date "2025.04.04"]
        [Round "-"]
        [White "NAGTest"]
        [Black "NAGTest"]
        [Result "*"]

        
        1. e4 $0 e5 $1 
        2. Nf3 $2 Nc6 $3 
        3. Bc4 $4 Bc5 $5 
        4. d3 $6 d6 $7 
        5. Nc3 $8 Nf6 $9 
        6. O-O $10 h6 $11 
        7. h3 $12 O-O $13 
        8. Be3 $14 Bb6 $15 
        9. Qd2 $16 Nd4 $17 
        10. Nxd4 $18 exd4 $19 
        11. Bxd4 $20 Bxd4 $21 
        12. Nd5 $22 Nxd5 $23 
        13. Bxd5 $24 Bxb2 $25 
        14. Rad1 $26 Bd4 $27 
        15. c3 $28 Bb6 $29 
        16. d4 $30 Kh8 $31 
        17. f4 $32 f5 $33 
        18. exf5 $34 Bxf5 $35 
        19. Bxb7 $36 Rb8 $37 
        20. Bf3 $38 d5 $39 
        21. g4 $40 Be4 $41 
        22. g5 $42 Qd6 $43 
        23. Rde1 $44 Rbe8 $45 
        24. Bxe4 $46 dxe4 $47 
        25. gxh6 $48 Qxh6 $49 
        26. Qg2 $50 e3 $51 
        27. Qf3 $52 c5 $53 
        28. Rxe3 $54 cxd4 $55 
        29. Rxe8 $56 dxc3+ $57 
        30. Kh1 $58 Rxe8 $59 
        31. Qxc3 $60 Re2 $61 
        32. Qc8+ $62 Kh7 $63 
        33. Qf5+ $64 Qg6 $65 
        34. Qg4 $66 Rxa2 $67 
        35. Qf3 $68 Qf5 $69 
        36. Qg4 $70 Qe4+ $71 
        37. Qf3 $72 Qxf3+ $73 
        38. Rxf3 $74 Kg6 $75 
        39. Rg3+ $76 Kf6 $77 
        40. h4 $78 Ra1+ $79 
        41. Kh2 $80 Bc7 $81 
        42. Rg4 $82 Ra5 $83 
        43. Kh3 $84 Rb5 $85 
        44. Rg1 $86 Bxf4 $87 
        45. Kg4 $88 Be5 $89 
        46. h5 $90 Rb4+ $91 
        47. Kf3 $92 Kf5 $93 
        48. Rc1 $94 Rb3+ $95 
        49. Ke2 $96 Ke4 $97 
        50. Rc4+ $98 Bd4 $99 
        51. Ra4 $100 Rb2+ $101 
        52. Ke1 $102 Rh2 $103 
        53. Ra3 $104 Rxh5 $105 
        54. Rb3 $106 Rh2 $107 
        55. Kd1 $108 Be3 $109 
        56. Rb7 $110 g5 $111 
        57. Rb5 $112 Kf3 $113 
        58. Rf5+ $114 Bf4 $115 
        59. Rd5 $116 Rd2+ $117 
        60. Rxd2 $118 Bxd2 $119 
        61. Kc2 $120 g4 $121 
        62. Kxd2 $122 g3 $123 
        63. Kc3 $124 g2 $125 
        64. Kc4 $126 g1=Q $127 
        65. Kd5 $128 Kf4 $129 
        66. Ke6 $130 Qd4 $131 
        67. Kf7 $132 Kf5 $133 
        68. Ke7 $134 Qd3 $135 
        69. Kf7 $136 Qd7+ $137 
        70. Kf8 $138 Kf6 $139
        *
        """
        
        let parser = PGNGameParser()
        let result = try! parser.parse(input)
        return result
    }()
}

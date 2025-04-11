//
//  GometryProxy+SquareWidht.swift
//  FischerUI
//
//  Created by Omar Megdadi on 11/4/25.
//

import SwiftUI
extension GeometryProxy {
    func squareWidth()-> CGFloat {
        let min = min(self.size.width, self.size.height)
        let squareSize = min / 8
        return squareSize
    }
}

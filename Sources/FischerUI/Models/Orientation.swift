//
//  Orientation.swift
//  FischerUI
//
//  Created by Omar Megdadi on 9/4/25.
//

public enum Orientation {
    case whiteSide
    case blackSide
    
    mutating func toggle() {
        self = self == .whiteSide ? .blackSide : .whiteSide
    }
    
    func isWhite() -> Bool {
        self == .whiteSide
    }
    
    func isblack() -> Bool {
        self == .blackSide
    }
}

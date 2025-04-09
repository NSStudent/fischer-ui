//
//  Orientation.swift
//  FischerUI
//
//  Created by Omar Megdadi on 9/4/25.
//

public enum Orientation {
    case whiteSite
    case blackSite
    
    mutating func toggle() {
        self = self == .whiteSite ? .blackSite : .whiteSite
    }
    
    func isWhite() -> Bool {
        self == .whiteSite
    }
    
    func isblack() -> Bool {
        self == .blackSite
    }
}

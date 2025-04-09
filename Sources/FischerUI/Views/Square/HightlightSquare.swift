//
//  HightlightSquare.swift
//  FischerUI
//
//  Created by Omar Megdadi on 9/4/25.
//
import SwiftUI

struct HightlightSquare: View {
    let color: Color    
    var body: some View {
        Rectangle()
            .fill(color)
            .opacity(0.3)
    }
}

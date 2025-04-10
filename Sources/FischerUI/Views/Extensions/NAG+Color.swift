//
//  NAG+Color.swift
//  FischerUI
//
//  Created by Omar Megdadi on 10/4/25.
//

import SwiftUI
import FischerCore

extension NAG {
    var color : Color {
        switch self {
        case .goodMove:
            return .green
        case .poorMove:
            return .red
        case .veryGoodMove:
            return .blue
        case .veryPoorMove:
            return .red
        case .speculativeMove:
            return .green
        case .questionableMove:
            return .yellow
        case .forcedMove:
            return .gray
        case .singularMove:
            return .orange
        case .worstMove:
            return .red
        case .drawishPosition:
            return .gray
        case .equalChancesQuiet:
            return .gray
        case .equalChancesActive:
            return .gray
        case .unclearPosition:
            return .gray
        default:
            return .gray
        }
    }
}

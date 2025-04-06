//
//  ContentView.swift
//  ShowCaseApp
//
//  Created by Omar Megdadi on 29/3/25.
//

import SwiftUI
import FischerUI

struct ContentView: View {
    let appTheme: AppTheme = .default
    var body: some View {
        VStack {
            BoardView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

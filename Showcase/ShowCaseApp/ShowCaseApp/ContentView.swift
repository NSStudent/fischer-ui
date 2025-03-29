//
//  ContentView.swift
//  ShowCaseApp
//
//  Created by Omar Megdadi on 29/3/25.
//

import SwiftUI
import FischerUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "square.grid.3x3.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello FischerUI, version \(Constants.version)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

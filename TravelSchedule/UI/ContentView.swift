//
//  ContentView.swift
//  TravelSchedule
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var fromStation: String = ""
    @State private var toStation: String = ""
    
    var body: some View {
        VStack(spacing: 24) {
            StationInputView(from: $fromStation, to: $toStation)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 252)
        .padding(.bottom, 32)
    }
}

#Preview {
    ContentView()
}

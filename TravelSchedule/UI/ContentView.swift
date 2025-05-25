//
//  ContentView.swift
//  TravelSchedule
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var fromStation: String = ""
    @State private var toStation: String = ""
    @State private var isSelectingFrom = false
    @State private var isSelectingTo = false
    
    var body: some View {
        VStack(spacing: 24) {
            StationInputView(
                from: $fromStation,
                to: $toStation,
                onFromTap: { isSelectingFrom = true },
                onToTap: { isSelectingTo = true }
            )

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 252)
        .padding(.bottom, 32)
        .sheet(isPresented: $isSelectingFrom) {
            CityAndStationSelectionView { result in
                fromStation = result
                isSelectingFrom = false
            }
        }
        .sheet(isPresented: $isSelectingTo) {
            CityAndStationSelectionView { result in
                toStation = result
                isSelectingTo = false
            }
        }
    }
}

#Preview {
    ContentView()
}

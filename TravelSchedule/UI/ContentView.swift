//
//  ContentView.swift
//  TravelSchedule
//

import SwiftUI

struct ContentView: View {
    @StateObject var travelViewModel = TravelViewModel()
    @State private var isSelectingFrom = false
    @State private var isSelectingTo = false
    @State private var isShowingCarrierList = false
    
    var body: some View {
        VStack(spacing: 24) {
            StationInputView(
                from: $travelViewModel.fromStation,
                to: $travelViewModel.toStation,
                onFromTap: { isSelectingFrom = true },
                onToTap: { isSelectingTo = true },
                onFindTap: { isShowingCarrierList = true }
            )

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 252)
        .padding(.bottom, 32)
        .sheet(isPresented: $isSelectingFrom) {
            CityAndStationSelectionView { result in
                travelViewModel.fromStation = result
                isSelectingFrom = false
            }
        }
        .sheet(isPresented: $isSelectingTo) {
            CityAndStationSelectionView { result in
                travelViewModel.toStation = result
                isSelectingTo = false
            }
        }
        .sheet(isPresented: $isShowingCarrierList) {
            CarrierListView()
                .environmentObject(travelViewModel)
                .id(travelViewModel.fromStation + travelViewModel.toStation)
        }
    }
}

#Preview {
    ContentView()
}

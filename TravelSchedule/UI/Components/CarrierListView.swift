//
//  CarrierListView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 01.06.2025.
//

import Foundation
import SwiftUI

struct LocalCarrier: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let logoName: String
    let date: String
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let note: String?
}

struct CarrierListView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    @Environment(\.colorScheme) private var colorScheme
    @State private var isShowingFilter = false

    private let carriers: [LocalCarrier] = LocalCarrier.mockData

    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                let from = travelViewModel.fromStation.isEmpty ? "Откуда" : travelViewModel.fromStation
                let to = travelViewModel.toStation.isEmpty ? "Куда" : travelViewModel.toStation
                Text("\(from) → \(to)")
                    .font(.system(size: 24, weight: .bold))
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                    .padding(.top, 16)
                    .padding(.horizontal, 16)

                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(carriers) { carrier in
                            CarrierCardView(carrier: carrier, colorScheme: colorScheme)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 16)

                Button {
                    isShowingFilter = true
                } label: {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color("White Universal"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color("Blue Universal"))
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                }
                .padding(.top, 8)
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            .background(Color("AppBackground").ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                    }
                }
            }
            
        }
        .fullScreenCover(isPresented: $isShowingFilter) {
            NavigationStack {
                FilterView()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                isShowingFilter = false
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    CarrierListView()
        .environmentObject(TravelViewModel())
}

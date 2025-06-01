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

    private let carriers: [LocalCarrier] = [
        LocalCarrier(
            title: "РЖД",
            subtitle: "Российские железные дороги",
            logoName: "rzd_logo",
            date: "14 января",
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов",
            note: "С пересадкой в Костроме"
        ),
        LocalCarrier(
            title: "ФГК",
            subtitle: "Федеральная грузовая компания",
            logoName: "fgk_logo",
            date: "15 января",
            departureTime: "10:00",
            arrivalTime: "18:30",
            duration: "8 часов 30 минут",
            note: nil
        ),
        LocalCarrier(
            title: "Урал",
            subtitle: "Уральская железная дорога",
            logoName: "ural_logo",
            date: "16 января",
            departureTime: "06:45",
            arrivalTime: "14:20",
            duration: "7 часов 35 минут",
            note: "Прямой рейс"
        )
    ]

    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                let from = travelViewModel.fromStation.isEmpty ? "Откуда" : travelViewModel.fromStation
                let to = travelViewModel.toStation.isEmpty ? "Куда" : travelViewModel.toStation
                Text("\(from) → \(to)")
                    .font(.system(size: 24, weight: .bold))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                    .padding(.top, 16)
                    .padding(.horizontal, 16)

                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(carriers) { carrier in
                            VStack(spacing: 0) {
                                HStack(alignment: .top, spacing: 12) {
                                    Image(carrier.logoName)
                                        .resizable()
                                        .frame(width: 38, height: 38)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(carrier.title)
                                            .font(.system(size: 17, weight: .regular))
                                            .foregroundStyle(Color("Black Universal"))
                                        if let note = carrier.note {
                                            Text(note)
                                                .font(.system(size: 12))
                                                .foregroundStyle(Color.red)
                                        }
                                    }

                                    Spacer()

                                    Text(carrier.date)
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color("Gray Universal"))
                                        .padding(.top, 2)
                                }

                                .padding(.bottom, 10)

                                HStack(spacing: 8) {
                                    Text(carrier.departureTime)
                                        .font(.system(size: 17))
                                        .foregroundStyle(Color("Black Universal"))

                                    Rectangle()
                                        .fill(Color("Gray Universal"))
                                        .frame(height: 1)

                                    Text(carrier.duration)
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color("Gray Universal"))

                                    Rectangle()
                                        .fill(Color("Gray Universal"))
                                        .frame(height: 1)

                                    Text(carrier.arrivalTime)
                                        .font(.system(size: 17))
                                        .foregroundStyle(Color("Black Universal"))
                                }
                            }
                            .padding(.all, 16)
                            .frame(maxWidth: .infinity, minHeight: 104, alignment: .leading)
                            .background(Color(red: 0.933, green: 0.933, blue: 0.933))
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 16)

                Button(action: {}) {
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
    }
}

#Preview {
    CarrierListView()
        .environmentObject(TravelViewModel())
}

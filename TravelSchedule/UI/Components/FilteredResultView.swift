//
//  FilteredResultView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 01.06.2025.
//

import Foundation
import SwiftUI


struct FilteredResultView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss

    private var filteredCarriers: [LocalCarrier] {
        let allCarriers = [
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

        return allCarriers.filter { carrier in
            let matchesTransfers = {
                if let allow = travelViewModel.allowTransfers {
                    return allow ? carrier.note != nil : carrier.note == nil
                }
                return true
            }()

            let matchesTime = {
                if travelViewModel.selectedTimes.isEmpty {
                    return true
                }
                let hour = Int(carrier.departureTime.prefix(2)) ?? 0
                for time in travelViewModel.selectedTimes {
                    switch time {
                    case let t where t.contains("06:00") && hour >= 6 && hour < 12: return true
                    case let t where t.contains("12:00") && hour >= 12 && hour < 18: return true
                    case let t where t.contains("18:00") && hour >= 18 && hour < 24: return true
                    case let t where t.contains("00:00") && hour >= 0 && hour < 6: return true
                    default: continue
                    }
                }
                return false
            }()

            return matchesTransfers && matchesTime
        }
    }

    var body: some View {
        let carriers = filteredCarriers
        return VStack(spacing: 0) {
            let from = travelViewModel.fromStation.isEmpty ? "Откуда" : travelViewModel.fromStation
            let to = travelViewModel.toStation.isEmpty ? "Куда" : travelViewModel.toStation

            Text("\(from) → \(to)")
                .font(.system(size: 24, weight: .bold))
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                .padding(.horizontal, 16)
                .padding(.top, 16)

            ScrollView {
                if carriers.isEmpty {
                    VStack {
                        Spacer()
                        Text("Вариантов нет")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 176)
                } else {
                    VStack(spacing: 8) {
                        ForEach(carriers) { carrier in
                            NavigationLink(destination:
                                CarrierDetailView(
                                    logoName: carrier.logoName,
                                    companyName: "ОАО «\(carrier.title)»",
                                    email: "i.lozgkina@yandex.ru",
                                    phone: "+7 (904) 329-27-71"
                                )
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarBackButtonHidden(true)
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button(action: {
                                            dismiss()
                                        }) {
                                            Image(systemName: "chevron.left")
                                                .foregroundColor(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                                        }
                                    }
                                }
                            ) {
                                VStack(spacing: 0) {
                                    HStack(alignment: .top, spacing: 12) {
                                        Image(uiImage: UIImage(named: carrier.logoName) ?? UIImage())
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: 38, height: 38)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(carrier.title)
                                                .font(.system(size: 17, weight: .regular))
                                                .foregroundColor(Color("Black Universal"))
                                            if let note = carrier.note {
                                                Text(note)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(Color.red)
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        Text(carrier.date)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color("Gray Universal"))
                                            .padding(.top, 2)
                                    }
                                    .padding(.bottom, 10)
                                    
                                    HStack(spacing: 8) {
                                        Text(carrier.departureTime)
                                            .font(.system(size: 17))
                                            .foregroundColor(Color("Black Universal"))
                                        
                                        Rectangle()
                                            .fill(Color("Gray Universal"))
                                            .frame(height: 1)
                                        
                                        Text(carrier.duration)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color("Gray Universal"))
                                        
                                        Rectangle()
                                            .fill(Color("Gray Universal"))
                                            .frame(height: 1)
                                        
                                        Text(carrier.arrivalTime)
                                            .font(.system(size: 17))
                                            .foregroundColor(Color("Black Universal"))
                                    }
                                }
                                .padding(16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(red: 0.933, green: 0.933, blue: 0.933))
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                            }
                        }
                    }
                    .padding(16)
                }
            }
            
            Button(action: {
                // Переоткрываем фильтр при необходимости
            }) {
                HStack(spacing: 8) {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color("White Universal"))
                    Circle()
                        .fill(Color("Red Universal"))
                        .frame(width: 6, height: 6)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color("Blue Universal"))
                .cornerRadius(20)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(colorScheme == .dark ? Color("AppBackground") : Color.white)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FilteredResultView()
        .environmentObject(TravelViewModel())
}

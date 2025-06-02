//
//  CityAndStationSelectionView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 25.05.2025.
//

import SwiftUI

struct CityAndStationSelectionView: View {
    let onResult: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedCity: String?
    @State private var selectedStation: String?
    @State private var searchText = ""
    @State private var stationSearchText = ""

    private let cities = [
        "Москва", "Санкт Петербург", "Сочи", "Горный воздух",
        "Краснодар", "Казань", "Омск"
    ]

    private let stations = [
        "Киевский вокзал",
        "Курский вокзал",
        "Ярославский вокзал",
        "Белорусский вокзал",
        "Савеловский вокзал",
        "Ленинградский вокзал"
    ]

    private var filteredCities: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    private var filteredStations: [String] {
        if stationSearchText.isEmpty {
            return stations
        } else {
            return stations.filter { $0.localizedCaseInsensitiveContains(stationSearchText) }
        }
    }

    var body: some View {
        NavigationStack {
            if selectedCity == nil {
                // Этап выбора города
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color("Gray Universal"))
                        TextField("Введите запрос", text: $searchText)
                            .font(.system(size: 17))
                            .foregroundColor(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                            .textInputAutocapitalization(.never)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 8)
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color("Gray Universal"))
                            }
                        }
                    }
                    .padding(.leading, 8)
                    .padding(.trailing, 6)
                    .frame(width: 343, height: 36)
                    .background(
                        colorScheme == .dark
                        ? Color(red: 0.46, green: 0.47, blue: 0.50)
                        : Color("Light Gray")
                    )
                    .cornerRadius(10)
                    .padding(.top, 16)
                    ScrollView {
                        VStack(spacing: 4) {
                            ForEach(filteredCities, id: \.self) { city in
                                Button(action: {
                                    selectedCity = city
                                }) {
                                    HStack {
                                        Text(city)
                                            .font(.system(size: 17, weight: .regular))
                                            .kerning(-0.41)
                                            .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .frame(width: 10.91, height: 18.82)
                                            .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                                    }
                                    .frame(height: 60)
                                    .padding(.horizontal, 16)
                                    .background(
                                        colorScheme == .dark
                                        ? Color("Black Universal")
                                        : Color("White Universal")
                                    )
                                    .cornerRadius(8)
                                    .contentShape(Rectangle())
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    }
                }
                .background(colorScheme == .dark ? Color("AppBackground") : Color.white)
                .navigationTitle("Выбор города")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                        }
                    }
                }
            } else {
                // Этап выбора станции
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color("Gray Universal"))
                        TextField("Введите запрос", text: $stationSearchText)
                            .font(.system(size: 17))
                            .foregroundColor(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                            .textInputAutocapitalization(.never)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 8)
                        if !stationSearchText.isEmpty {
                            Button(action: {
                                stationSearchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color("Gray Universal"))
                            }
                        }
                    }
                    .padding(.leading, 8)
                    .padding(.trailing, 6)
                    .frame(width: 343, height: 36)
                    .background(
                        colorScheme == .dark
                        ? Color(red: 0.46, green: 0.47, blue: 0.50)
                        : Color("Light Gray")
                    )
                    .cornerRadius(10)
                    .padding(.top, 16)
                    ScrollView {
                        VStack(spacing: 4) {
                            ForEach(filteredStations, id: \.self) { station in
                                Button(action: {
                                    let result = "\(selectedCity!) (\(station))"
                                    onResult(result)
                                    dismiss()
                                }) {
                                    HStack {
                                        Text(station)
                                            .font(.system(size: 17, weight: .regular))
                                            .kerning(-0.41)
                                            .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .frame(width: 10.91, height: 18.82)
                                            .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                                    }
                                    .frame(height: 60)
                                    .padding(.horizontal, 16)
                                    .background(
                                        colorScheme == .dark
                                        ? Color("Black Universal")
                                        : Color("White Universal")
                                    )
                                    .cornerRadius(8)
                                    .contentShape(Rectangle())
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    }
                }
                .background(colorScheme == .dark ? Color("AppBackground") : Color.white)
                .navigationTitle("Выбор станции")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            selectedCity = nil
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                        }
                    }
                }
            }
        }
        .background(colorScheme == .dark ? Color("AppBackground") : Color.white)
    }
}

#Preview {
    CityAndStationSelectionView { result in
        print("Selected:", result)
    }
}

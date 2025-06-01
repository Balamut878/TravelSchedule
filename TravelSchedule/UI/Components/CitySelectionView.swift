//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 16.05.2025.
//
//
// Этот файл оставлен в проекте на всякий случай.
// Использовался для раздельной реализации экранов выбора города и станции.
// Сейчас используется объединённый экран `CityAndStationSelectionView.swift`.
// Можно использовать этот файл при необходимости вернуться к раздельной навигации.
//

import SwiftUI

struct CitySelectionView: View {
    let onCitySelected: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    
    private let allCities = [
        "Москва", "Санкт Петербург", "Сочи", "Горный воздух",
        "Краснодар", "Казань", "Омск"
    ]
    
    var filteredCities: [String] {
        if searchText.isEmpty {
            return allCities
        } else {
            return allCities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                // Кастомное поле поиска
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
                    ? Color(red: 0.46, green: 0.47, blue: 0.50) // #767680
                    : Color("Light Gray")
                )
                .cornerRadius(10)
                .padding(.top, 16)

                // Список или заглушка
                if filteredCities.isEmpty {
                    Spacer()
                    Text("Город не найден")
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 4) {
                            ForEach(filteredCities, id: \.self) { city in
                                NavigationLink(destination: StationSelectionView()) {
                                    HStack {
                                        Text(city)
                                            .font(.system(size: 17, weight: .regular))
                                            .kerning(-0.41)
                                            .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                                        Spacer()
                                        Image(systemName: "chevron.right")
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
            }
            .background(Color("AppBackground"))
            .navigationTitle("Выбор города")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}

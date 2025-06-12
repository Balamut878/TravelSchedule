//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 25.05.2025.
//
//
// Этот файл оставлен в проекте на всякий случай.
// Использовался для раздельной реализации экранов выбора города и станции.
// Сейчас используется объединённый экран `CityAndStationSelectionView.swift`.
// Можно использовать этот файл при необходимости вернуться к раздельной навигации.
//

import SwiftUI

struct StationSelectionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode
    @State private var searchText = ""
    
    // Мок-данные станций
    private let stations = [
        "Киевский вокзал",
        "Курский вокзал",
        "Ярославский вокзал",
        "Белорусский вокзал",
        "Савеловский вокзал",
        "Ленинградский вокзал"
    ]
    
    var filteredStations: [String] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
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
                ? Color(red: 0.46, green: 0.47, blue: 0.50)
                : Color("Light Gray")
            )
            .cornerRadius(10)
            .padding(.top, 16)

            ScrollView {
                VStack(spacing: 4) {
                    ForEach(filteredStations, id: \.self) { station in
                        HStack {
                            Text(station)
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
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
        }
        .background(AppColors.background)
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                }
            }
        }
        .toolbarBackground(AppColors.background, for: .navigationBar)
    }
}

#Preview {
    StationSelectionView()
}

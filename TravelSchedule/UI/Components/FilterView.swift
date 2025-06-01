//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 01.06.2025.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    @State private var selectedTimes: Set<String> = []
    @State private var showTransfers: Bool?

    let timeOptions = [
        "Утро 06:00 - 12:00",
        "День 12:00 - 18:00",
        "Вечер 18:00 - 00:00",
        "Ночь 00:00 - 06:00"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))

            ForEach(timeOptions, id: \.self) { option in
                HStack {
                    Text(option)
                        .font(.system(size: 17, weight: .regular))
                        .kerning(-0.41)
                    Spacer()
                    Image(selectedTimes.contains(option) ? "checkbox_on" : "checkbox_off")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            if selectedTimes.contains(option) {
                                selectedTimes.remove(option)
                            } else {
                                selectedTimes.insert(option)
                            }
                        }
                }
            }

            Text("Показывать варианты с пересадками")
                .font(.system(size: 24, weight: .bold))

            HStack {
                Text("Да")
                    .font(.system(size: 17, weight: .regular))
                    .kerning(-0.41)
                Spacer()
                Image(showTransfers == true ? "radio_on" : "radio_off")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        showTransfers = true
                    }
            }

            HStack {
                Text("Нет")
                    .font(.system(size: 17, weight: .regular))
                    .kerning(-0.41)
                Spacer()
                Image(showTransfers == false ? "radio_on" : "radio_off")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        showTransfers = false
                    }
            }

            Spacer()

            if !selectedTimes.isEmpty || showTransfers != nil {
                Button(action: {
                    dismiss()
                }) {
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 343, height: 60)
                        .background(Color("Blue Universal"))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 8)
                .padding(.top, 20)
                .padding(.bottom, 20)
            }
        }
        .padding(16)
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    NavigationStack {
        FilterView()
    }
}

//
//  StationRowView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 22.06.2025.
//

import SwiftUI

struct StationRowView: View {
    let station: Station
    let onSelect: () -> Void
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: onSelect) {
            HStack {
                Text(station.title ?? "Без названия")
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

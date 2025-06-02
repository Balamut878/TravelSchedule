//
//  ErrorView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 01.06.2025.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let imageName: String
    let message: String

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 24) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
                .clipShape(RoundedRectangle(cornerRadius: 70))

            Text(message)
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("AppBackground").ignoresSafeArea())
    }
}

#Preview {
    Group {
        ErrorView(imageName: "server_error", message: "Ошибка сервера")
        ErrorView(imageName: "no_Internet", message: "Нет интернета")
    }
}

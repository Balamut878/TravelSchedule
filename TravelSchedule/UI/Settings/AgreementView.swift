//
//  AgreementView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 21.05.2025.
//

import SwiftUI

struct AgreementView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Link(
                    "Полный текст пользовательского соглашения доступен по ссылке",
                    destination: URL(string: "https://yandex.ru/legal/practicum_termsofuse/")!
                )
                .font(.body)
                .foregroundStyle(.blue)
                .underline()
            }
            .padding()
        }
        .background(AppColors.background)
        .toolbarBackground(AppColors.background, for: .navigationBar)
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(
                            colorScheme == .dark
                                ? Color("White Universal")
                                : Color("Black Universal")
                        )
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        AgreementView()
    }
}

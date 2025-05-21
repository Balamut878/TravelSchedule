//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 21.05.2025.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 4) {
                    HStack {
                        Text("Тёмная тема")
                            .font(.system(size: 17))
                            .foregroundStyle(isDarkMode ? Color("White Universal") : Color("Black Universal"))
                        Spacer()
                        Toggle("", isOn: $isDarkMode)
                            .labelsHidden()
                            .tint(Color("Blue Universal"))
                    }
                    .frame(height: 60)
                    .padding(.horizontal, 16)
                    .background(isDarkMode ? Color("Black Universal") : Color("White Universal"))

                    NavigationLink(destination: AgreementView()) {
                        HStack {
                            Text("Пользовательское соглашение")
                                .font(.system(size: 17))
                                .foregroundStyle(isDarkMode ? Color("White Universal") : Color("Black Universal"))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(isDarkMode ? Color("White Universal") : Color("Black Universal"))
                        }
                        .frame(height: 60)
                        .padding(.horizontal, 16)
                        .background(isDarkMode ? Color("Black Universal") : Color("White Universal"))
                    }
                }
                .padding(.top, 16)

                VStack(spacing: 4) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .font(.system(size: 12))
                        .foregroundStyle(isDarkMode ? Color("White Universal") : Color("Black Universal"))
                        .multilineTextAlignment(.center)

                    Text("Версия 1.0 (beta)")
                        .font(.system(size: 12))
                        .foregroundStyle(isDarkMode ? Color("White Universal") : Color("Black Universal"))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 107)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            .background(AppColors.background)
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    SettingsView()
}

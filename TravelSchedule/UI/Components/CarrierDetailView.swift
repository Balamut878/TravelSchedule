//
//  CarrierDetailView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 01.06.2025.
//


import SwiftUI

struct CarrierDetailView: View {
    let logoName: String
    let companyName: String
    let email: String
    let phone: String

    var body: some View {
        VStack(spacing: 24) {
            Image(logoName)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)

            Text(companyName)
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top, 8)

            VStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("E-mail")
                        .font(.system(size: 17, weight: .regular))
                        .kerning(-0.41)
                    Text(email)
                        .font(.system(size: 12, weight: .regular))
                        .kerning(0.4)
                        .foregroundStyle(Color("Blue Universal"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 60)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                        .kerning(-0.41)
                    Text(phone)
                        .font(.system(size: 12, weight: .regular))
                        .kerning(0.4)
                        .foregroundStyle(Color("Blue Universal"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 60)
            }
            .padding(.horizontal, 16)

            Spacer()
        }
        .background(Color("AppBackground"))
        .padding(.top, 32)
        .padding(.horizontal, 0)
        .background(Color("AppBackground").ignoresSafeArea())
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CarrierDetailView(
        logoName: "rzd_logo",
        companyName: "ОАО «РЖД»",
        email: "i.ozgkina@yandex.ru",
        phone: "+7 (904) 329-27-71"
    )
}

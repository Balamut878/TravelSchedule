//
//  CarrierCardView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 12.06.2025.
//

import Foundation
import SwiftUI

struct CarrierCardView: View {
    let carrier: LocalCarrier
    let colorScheme: ColorScheme

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                Image(carrier.logoName)
                    .resizable()
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                VStack(alignment: .leading, spacing: 2) {
                    Text(carrier.title)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color("Black Universal"))
                    if let note = carrier.note {
                        Text(note)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.red)
                    }
                }

                Spacer()

                Text(carrier.date)
                    .font(.system(size: 12))
                    .foregroundStyle(Color("Gray Universal"))
                    .padding(.top, 2)
            }
            .padding(.bottom, 10)

            HStack(spacing: 8) {
                Text(carrier.departureTime)
                    .font(.system(size: 17))
                    .foregroundStyle(Color("Black Universal"))

                Rectangle()
                    .fill(Color("Gray Universal"))
                    .frame(height: 1)

                Text(carrier.duration)
                    .font(.system(size: 12))
                    .foregroundStyle(Color("Gray Universal"))

                Rectangle()
                    .fill(Color("Gray Universal"))
                    .frame(height: 1)

                Text(carrier.arrivalTime)
                    .font(.system(size: 17))
                    .foregroundStyle(Color("Black Universal"))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.933, green: 0.933, blue: 0.933))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

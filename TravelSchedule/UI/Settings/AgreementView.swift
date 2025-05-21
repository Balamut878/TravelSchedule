//
//  AgreementView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 21.05.2025.
//

import Foundation
import SwiftUI

struct AgreementView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Пользовательское соглашение")
                    .font(.title2.bold())
                    .padding(.bottom)
                
                Text("здесь будет текст!!!")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AgreementView()
}

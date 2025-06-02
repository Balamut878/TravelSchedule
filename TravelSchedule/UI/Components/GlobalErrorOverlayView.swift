//
//  GlobalErrorOverlayView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 02.06.2025.
//

import Foundation
import SwiftUI

struct GlobalErrorOverlayView<Content: View>: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            content

            if let error = travelViewModel.travelError {
                ErrorView(
                    imageName: error == .server ? "server_error" : "no_Internet",
                    message: error == .server ? "Ошибка сервера" : "Нет интернета"
                )
                .transition(.opacity)
                .zIndex(1)
            }
        }
    }
}

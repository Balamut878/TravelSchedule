//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 05.05.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject private var travelViewModel = TravelViewModel()

    var body: some Scene {
        WindowGroup {
            GlobalErrorOverlayView {
                MainTabView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                    .environmentObject(travelViewModel)
            }
            .environmentObject(travelViewModel)
        }
    }
}

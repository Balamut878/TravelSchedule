//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 15.05.2025.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    @State var selectedIndex = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedIndex {
                case 0:
                    ContentView()
                case 1:
                    SettingsView()
                default:
                    ContentView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.background.ignoresSafeArea())

            VStack(spacing: 0) {
                Divider()
                    .frame(height: 0.5)
                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.3))
                HStack(spacing: 113) {
                    tabBarButton(index: 0, imageName: "Schedule")
                    tabBarButton(index: 1, imageName: "Settings")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 49)
                .padding(.horizontal, 56)
                .background(AppColors.background)
            }
        }
    }
    
    private func tabBarButton(index: Int, imageName: String) -> some View {
        Button(action: {
            selectedIndex = index
        }) {
            Image(imageName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(selectedIndex == index ? AppColors.activeTab : AppColors.inactiveTab)
                .frame(width: 75, height: 49)
        }
    }
}

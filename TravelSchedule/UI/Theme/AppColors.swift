//
//  AppColors.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 15.05.2025.
//

import Foundation
import SwiftUI

struct AppColors {
    static var background: Color {
        Color("AppBackground", bundle: nil)
    }
    
    static var primary: Color {
        Color("PrimaryText", bundle:  nil)
    }
    
    static var activeTab: Color {
        Color("TabBarActive", bundle: nil)
    }
    
    static var inactiveTab: Color {
        Color("TabBarInactive", bundle: nil)
    }
}

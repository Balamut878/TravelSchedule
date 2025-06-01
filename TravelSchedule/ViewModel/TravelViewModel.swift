//
//  TravelViewModel.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 01.06.2025.
//

import Foundation
import SwiftUI

final class TravelViewModel: ObservableObject {
    @Published var fromStation: String = ""
    @Published var toStation: String = ""
    @Published var originStation: String = ""
    @Published var destinationStation: String = ""
}

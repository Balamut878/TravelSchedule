//
//  CityAndStationSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 22.06.2025.
//

import Foundation
import SwiftUI

@MainActor
final class CityAndStationSelectionViewModel: ObservableObject {
    @Published var stations: [Station] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let networkService = NetworkService()

    func loadStations(lat: Double, lng: Double) async {
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await networkService.getNearestStations(
                lat: lat,
                lng: lng,
                distance: 50
            )
            self.stations = result.stations ?? []
        } catch {
            errorMessage = "Не удалось загрузить станции: \(error.localizedDescription)"
        }
    }
}

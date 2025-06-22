//
//  TravelViewModel.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 01.06.2025.
//

import Foundation
import SwiftUI
import Network

final class TravelViewModel: ObservableObject {
    enum TravelError {
        case noInternet
        case server
    }

    @Published var travelError: TravelError? = nil
    @Published var fromStation: String = ""
    @Published var toStation: String = ""
    @Published var selectedFromStation: Station? = nil
    @Published var selectedToStation: Station? = nil
    @Published var originStation: String = ""
    @Published var destinationStation: String = ""
    @Published var selectedTimes: Set<String> = []
    @Published var allowTransfers: Bool? = nil

    @Published var allCarriers: [LocalCarrier] = [
        LocalCarrier(
            title: "РЖД",
            subtitle: "Российские железные дороги",
            logoName: "rzd_logo",
            date: "14 января",
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов",
            note: "С пересадкой в Костроме"
        ),
        LocalCarrier(
            title: "ФГК",
            subtitle: "Федеральная грузовая компания",
            logoName: "fgk_logo",
            date: "15 января",
            departureTime: "10:00",
            arrivalTime: "18:30",
            duration: "8 часов 30 минут",
            note: nil
        ),
        LocalCarrier(
            title: "Урал",
            subtitle: "Уральская железная дорога",
            logoName: "ural_logo",
            date: "16 января",
            departureTime: "06:45",
            arrivalTime: "14:20",
            duration: "7 часов 35 минут",
            note: "Прямой рейс"
        )
    ]

    @Published var stations: [Station] = []

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .unsatisfied {
                    self?.travelError = .noInternet
                } else {
                    self?.travelError = nil
                }
            }
        }
        monitor.start(queue: queue)
    }

    func simulateServerError() {
        travelError = .server
    }

    func clearError() {
        travelError = nil
    }

    var filteredCarriers: [LocalCarrier] {
        allCarriers.filter { carrier in
            let matchesTime = selectedTimes.isEmpty || selectedTimes.contains(where: { timeRange in
                if timeRange.contains("Утро") {
                    return carrier.departureTime >= "06:00" && carrier.departureTime < "12:00"
                }
                if timeRange.contains("День") {
                    return carrier.departureTime >= "12:00" && carrier.departureTime < "18:00"
                }
                if timeRange.contains("Вечер") {
                    return carrier.departureTime >= "18:00" && carrier.departureTime <= "23:59"
                }
                if timeRange.contains("Ночь") {
                    return carrier.departureTime >= "00:00" && carrier.departureTime < "06:00"
                }
                return true
            })

            let matchesTransfers = allowTransfers == nil || (carrier.note?.contains("пересад") ?? false) == allowTransfers!

            return matchesTime && matchesTransfers
        }
    }
}

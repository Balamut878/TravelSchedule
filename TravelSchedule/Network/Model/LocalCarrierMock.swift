//
//  LocalCarrierMock.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 12.06.2025.
//

import Foundation

extension LocalCarrier {
    static let mockData: [LocalCarrier] = [
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
}

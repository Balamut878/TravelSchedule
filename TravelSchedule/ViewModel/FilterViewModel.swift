//
//  FilterViewModel.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 22.06.2025.
//

import Foundation

final class FilterViewModel: ObservableObject {
    @Published var selectedTimes: Set<String> = []
    @Published var showTransfers: Bool? = nil

    let timeOptions = [
        "Утро 06:00 - 12:00",
        "День 12:00 - 18:00",
        "Вечер 18:00 - 00:00",
        "Ночь 00:00 - 06:00"
    ]

    func toggleTimeOption(_ option: String) {
        if selectedTimes.contains(option) {
            selectedTimes.remove(option)
        } else {
            selectedTimes.insert(option)
        }
    }

    func setTransfers(_ allow: Bool) {
        showTransfers = allow
    }

    var isApplyButtonEnabled: Bool {
        !selectedTimes.isEmpty || showTransfers != nil
    }
}

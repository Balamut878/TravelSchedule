//
//  Story.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 12.06.2025.
//

import Foundation

struct Story: Identifiable {
    let id = UUID()
    let previewImage: String
    let slides: [String]
    let title: String
    var isViewed: Bool
}

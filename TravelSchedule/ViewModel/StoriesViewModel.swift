//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 22.06.2025.
//

import Foundation

@MainActor
final class StoriesViewModel: ObservableObject {
    @Published var stories: [Story] = []

    init() {
        loadStories()
    }

    func loadStories() {
        stories = Story.mockData
    }

    func markStoryViewed(_ story: Story) {
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            stories[index].isViewed = true
        }
    }
}

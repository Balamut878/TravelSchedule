//
//  StoriesScrollView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 14.06.2025.
//

import SwiftUI

struct StoriesScrollView: View {
    @State var stories: [Story]
    @State private var selectedStory: Story?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(stories) { story in
                        StoryPreviewView(story: story)
                            .onTapGesture {
                                selectedStory = story
                            }
                    }
                }
                .padding(.leading, 16)
            }
            .scrollIndicators(.hidden)
            .frame(height: 140)
            .padding(.top, 24)
        }
        .fullScreenCover(item: $selectedStory) { story in
            StorySlidesView(
                slides: story.slides,
                startingIndex: 0,
                onNextStory: {
                    goToNextStory(after: story)
                },
                onPreviousStory: {
                    goToPreviousStory(before: story)
                },
                markStoryViewed: {
                    markViewed(story: story)
                }
            )
            .preferredColorScheme(.dark)
        }
    }

    private func goToNextStory(after story: Story) {
        guard let currentIndex = stories.firstIndex(where: { $0.id == story.id }) else { return }
        if currentIndex + 1 < stories.count {
            selectedStory = stories[currentIndex + 1]
        } else {
            selectedStory = nil
        }
    }

    private func goToPreviousStory(before story: Story) {
        guard let currentIndex = stories.firstIndex(where: { $0.id == story.id }) else { return }
        if currentIndex > 0 {
            selectedStory = stories[currentIndex - 1]
        } else {
            selectedStory = nil
        }
    }

    private func markViewed(story: Story) {
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            stories[index].isViewed = true
        }
    }
}

#Preview {
    StoriesScrollView(stories: Story.mockData)
}

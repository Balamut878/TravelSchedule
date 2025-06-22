//
//  StoriesScrollView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 14.06.2025.
//

import SwiftUI

struct StoriesScrollView: View {
    @StateObject private var viewModel = StoriesViewModel()
    @State private var selectedStory: Story?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(viewModel.stories) { story in
                        StoryPreviewView(story: story)
                            .environmentObject(viewModel)
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
                    if let story = selectedStory {
                        viewModel.markStoryViewed(story)
                    }
                }
            )
            .preferredColorScheme(.dark)
        }
    }

    private func goToNextStory(after story: Story) {
        guard let currentIndex = viewModel.stories.firstIndex(where: { $0.id == story.id }) else { return }
        if currentIndex + 1 < viewModel.stories.count {
            selectedStory = viewModel.stories[currentIndex + 1]
        } else {
            selectedStory = nil
        }
    }

    private func goToPreviousStory(before story: Story) {
        guard let currentIndex = viewModel.stories.firstIndex(where: { $0.id == story.id }) else { return }
        if currentIndex > 0 {
            selectedStory = viewModel.stories[currentIndex - 1]
        } else {
            selectedStory = nil
        }
    }
}

#Preview {
    StoriesScrollView()
}

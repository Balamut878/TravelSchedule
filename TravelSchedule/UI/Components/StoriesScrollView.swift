//
//  StoriesScrollView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 14.06.2025.
//

import Foundation
import SwiftUI

struct StoriesScrollView: View {
    @State var stories: [Story]
    @State private var selectedStory: Story?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
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
            .frame(height: 140)
            .padding(.top, 24)
        }
        .fullScreenCover(item: $selectedStory) { story in
            StorySlidesView(
                slides: story.slides,
                startingIndex: 0,
                onNextStory: {
                    if let currentIndex = stories.firstIndex(where: { $0.id == story.id }),
                       currentIndex + 1 < stories.count {
                        selectedStory = stories[currentIndex + 1]
                    } else {
                        selectedStory = nil
                    }
                },
                onPreviousStory: {
                    if let currentIndex = stories.firstIndex(where: { $0.id == story.id }), currentIndex > 0 {
                        selectedStory = stories[currentIndex - 1]
                    } else {
                        selectedStory = nil
                    }
                },
                markStoryViewed: {
                    if let index = stories.firstIndex(where: { $0.id == story.id }) {
                        stories[index].isViewed = true
                    }
                }
            )
        }
    }
}

#Preview {
    StoriesScrollView(stories: Story.mockData)
}

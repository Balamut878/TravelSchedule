//
//  StoryPreviewView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 12.06.2025.
//

import Foundation
import SwiftUI

struct StoryPreviewView: View {
    let story: Story

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.previewImage)
                .resizable()
                .scaledToFill()
                .frame(width: 92, height: 140)
                .clipped()
                .opacity(story.isViewed ? 0.5 : 1)

            Text(story.title)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .padding(6)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(story.isViewed ? Color.clear : Color("Blue Universal"), lineWidth: 4)
        )
        .cornerRadius(16)
    }
}

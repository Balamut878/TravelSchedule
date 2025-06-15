//
//  StorySlidesView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 14.06.2025.
//

import Foundation
import SwiftUI

struct StorySlidesView: View {
    let markStoryViewed: (() -> Void)?
    let slides: [String]
    let startingIndex: Int
    let onNextStory: (() -> Void)?
    @State private var currentIndex: Int

    init(slides: [String], startingIndex: Int = 0, onNextStory: (() -> Void)? = nil, markStoryViewed: (() -> Void)? = nil) {
        self.slides = slides
        self.startingIndex = startingIndex
        self.onNextStory = onNextStory
        self.markStoryViewed = markStoryViewed
        _currentIndex = State(initialValue: startingIndex)
    }

    @Environment(\.dismiss) private var dismiss
    @State private var timer: Timer? = nil
    @State private var progress: CGFloat = 0

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                TabView(selection: $currentIndex) {
                    ForEach(Array(slides.enumerated()), id: \.offset) { index, slide in
                        ZStack {
                            Image(slide)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 710)
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
                            VStack {
                                Spacer()
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Здесь должен быть какой то текст!")
                                        .font(.system(size: 34, weight: .bold))
                                        .foregroundColor(Color("White Universal"))
                                        .lineLimit(2)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    Text("Здесь должен быть какой то текст!")
                                        .font(.system(size: 20, weight: .regular))
                                        .foregroundColor(Color("White Universal"))
                                        .lineLimit(3)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(.horizontal, 16)
                                .padding(.bottom, 40)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)]),
                                                   startPoint: .top, endPoint: .bottom)
                                )
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 710)
                .onAppear {
                    markStoryViewed?()
                    startAutoPlay()
                }
                .onDisappear { stopAutoPlay() }
                .onChange(of: currentIndex) { _ in
                    progress = 0
                }
            }

            HStack(spacing: 8) {
                ForEach(0..<slides.count, id: \.self) { index in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.3))
                        GeometryReader { geometry in
                            Capsule()
                                .fill(Color.blue)
                                .frame(width: currentIndex == index
                                       ? geometry.size.width * progress
                                       : index < currentIndex
                                         ? geometry.size.width
                                         : 0)
                        }
                    }
                    .frame(height: 4)
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 4)
            .padding(.horizontal, 16)
            .padding(.top, 12)

            Button(action: {
                dismiss()
            }) {
                Image("CloseButton")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .padding(.top, 50)
            .padding(.trailing, 16)
        }
        .ignoresSafeArea()
    }

    private func startAutoPlay() {
        currentIndex = startingIndex
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if progress >= 1.0 {
                if currentIndex == slides.count - 1 {
                    stopAutoPlay()
                    if let onNextStory = onNextStory {
                        onNextStory()
                    } else {
                        dismiss()
                    }
                    return
                } else {
                    progress = 0
                    currentIndex += 1
                }
            } else {
                progress += 0.05 / 2
            }
        }
    }

    private func stopAutoPlay() {
        timer?.invalidate()
        timer = nil
    }
}

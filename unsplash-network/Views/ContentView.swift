//
//  ContentView.swift
//  unsplash-network
//
//  Created by Axel ROUQUETTE on 1/23/24.
//

import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
    }
}

struct ContentView: View {
    @StateObject var imagesFeed = FeedState<[UnsplashModel]>()
    @StateObject var topicFeed = FeedState<[UnsplashTopic]>()
    
    func fetchData() async {
        await self.topicFeed.fetchFeed(path: "/topics")
        await self.imagesFeed.fetchFeed(path: "/photos")
    }
    
    var body: some View {
        NavigationStack() {
            VStack {
                ScrollView {
                    Button(action: {
                        Task {
                            await fetchData()
                        }
                    }, label: {
                        Text("Load Images")
                    })
                    TopicGrid(
                        data: topicFeed.feed
                    )
                    ImageGridView(
                        data: imagesFeed.feed
                    )
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }.navigationTitle("Feed")
        }.padding(8)
    }
}



//
//  TopicView.swift
//  UnsplashApp
//
//  Created by Axel ROUQUETTE on 1/24/24.
//

import SwiftUI

struct TopicView: View {
    @StateObject var topicFeed = FeedState<[UnsplashModel]>()
    var topic: UnsplashTopic

    func fetchData() async {
        await topicFeed.fetchFeed(path:"/topics/\(topic.id)/photos")
    }
    
    var body: some View {
        Button(action: {
            Task {
                await fetchData()
            }
        }, label: {
            Text("Load Images")
        })
        ScrollView {
            ImageGridView(data: topicFeed.feed )
        }.navigationTitle(topic.title)

    }
}

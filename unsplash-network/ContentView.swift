//
//  ContentView.swift
//  unsplash-network
//
//  Created by Axel ROUQUETTE on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var feedState = FeedState()
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    func loadData() async {
        await feedState.fetchHomeFeed()
    }

    var body: some View {
        NavigationStack() {
            Text("Feed")
        }
        .frame(height: 30)
        .font(.largeTitle)
        VStack {
            Button(action: {
                Task {
                    await loadData()
                }
            }, label: {
                Text("Load Data")
            })
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(feedState.homeFeed ?? [], id: \.id) { imageUrl in
                        AsyncImage(url: URL(string: imageUrl.urls.regular)) { image in
                            image
                                .centerCropped()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(12)
        }
    }
}

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

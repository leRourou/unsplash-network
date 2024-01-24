//
//  TopicGrid.swift
//  UnsplashApp
//
//  Created by Axel ROUQUETTE on 1/24/24.
//

import SwiftUI

struct TopicGrid: View {
    var data: [UnsplashTopic]?
    let rows: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                if let data {
                    ForEach(data, id: \.id) { topic in
                        VStack {
                            AsyncImage(url: URL(string: topic.coverPhoto.urls.small)) { img in
                                img
                                    .resizable()
                                    .frame(width: 150, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 150, height: 100)
                                    .foregroundColor(Color(hex: topic.coverPhoto.color))
                                    .overlay(ProgressView())
                            }
                            NavigationLink(destination: TopicView(topic: topic)) {
                                Text(topic.title)
                                    .font(.system(size: 12))
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 10)
                            }
                        }
                    }
                } else {
                    ForEach(0..<12, id: \.self) { _ in
                        VStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 150, height: 100)
                                .foregroundColor(Color(UIColor.lightGray))
                            Text("Topic")
                                .font(.system(size: 12))
                                .foregroundColor(Color(UIColor.lightGray))
                                .padding(.top, 10)
                        }
                    }
                }
            }
        }.frame(height: 150)
        
    }
}

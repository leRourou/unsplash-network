//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Axel ROUQUETTE on 1/23/24.
//

import Foundation
import SwiftUI

let SCHEME = "https"
let HOST = "api.unsplash.com"
let CLIENT_ID = ConfigurationManager.instance.plistDictionnary.clientId

func unsplashApiBaseUrl() -> URLComponents {
    var components = URLComponents()
    components.scheme = SCHEME
    components.host = HOST
    components.queryItems = [URLQueryItem(name: "client_id", value: CLIENT_ID)]
    return components
}

func feedUrl(
    path: String = "/photos",
    orderBy: String = "popular",
    perPage: Int = 10
) -> URL? {
    var components = unsplashApiBaseUrl()
    components.path = path
    components.queryItems?.append(contentsOf: [
        URLQueryItem(name: "per_page", value: String(perPage)),
        URLQueryItem(name: "order_by", value: orderBy)
    ])
    return components.url
}

class FeedState<T: Decodable>: ObservableObject {
    @Published var feed: T?

    func fetchFeed(path: String) async {
        let url = feedUrl(path: path)!
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode(T.self, from: data)
            feed = deserializedData
        } catch let error {
            print(error)
        }
    }
}

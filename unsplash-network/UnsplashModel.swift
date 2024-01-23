//
//  UnsplashImage.swift
//  UnsplashApp
//
//  Created by Axel ROUQUETTE on 1/23/24.
//

import Foundation

// MARK: - UnsplashModel
struct UnsplashModel: Codable, Identifiable {
    let id, slug: String
    let urls: Urls
    let user: User
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let username, name: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case username, name
    }
}


let scheme = "https"
let host = "api.unsplash.com"
let clientId = ConfigurationManager.instance.plistDictionnary.clientId

func unsplashApiBaseUrl() -> URLComponents {
    var components = URLComponents()
    components.scheme = scheme
    components.host = host
    components.queryItems = [URLQueryItem(name: "client_id", value: clientId)]
    return components
}

func feedUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {
    var components = unsplashApiBaseUrl()
    components.path = "/photos"
    components.queryItems?.append(contentsOf: [
        URLQueryItem(name: "order_by", value: orderBy),
        URLQueryItem(name: "per_page", value: String(perPage))
    ])
    return components.url
}

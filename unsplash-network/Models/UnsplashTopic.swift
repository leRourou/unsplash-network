//
//  UnsplashTopic.swift
//  UnsplashApp
//
//  Created by Axel ROUQUETTE on 1/24/24.
//

import Foundation

// MARK: - UnslpashTopic
struct UnsplashTopic: Codable, Identifiable {
    let id, slug, title, description: String
    let coverPhoto: CoverPhoto

    enum CodingKeys: String, CodingKey {
        case id, slug, title, description
        case coverPhoto = "cover_photo"
    }
}

struct CoverPhoto: Codable {
    let id, slug: String
    let urls: Urls
    let color: String

    enum CodingKeys: String, CodingKey {
        case id, slug, urls, color
    }
}

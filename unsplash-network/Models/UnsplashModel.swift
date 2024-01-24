//
//  UnsplashImage.swift
//  UnsplashApp
//
//  Created by Axel ROUQUETTE on 1/23/24.
//

import Foundation

// MARK: - UnsplashModel
struct UnsplashModel: Codable, Identifiable {
    let id : String
    let slug: String
    let color: String
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
    let location: String?
    let totalPhotos: Int
    let profileImage: ProfileImage
    let totalLikes: Int
    let links: ProfileLinks
    
    enum CodingKeys: String, CodingKey {
        case id
        case username, name
        case location
        case totalPhotos = "total_photos"
        case profileImage = "profile_image"
        case totalLikes = "total_likes"
        case links = "links"
    }
    
    func getPseudo()->String {
        return "@\(self.username.lowercased())"
    }
    
}

struct ProfileImage: Codable {
    let small, medium, large: String
}

struct ProfileLinks: Codable {
    let html: String
}





//
//  SwiftUIView.swift
//  UnsplashApp
//
//  Created by Axel ROUQUETTE on 1/24/24.
//

import SwiftUI

struct AuthorView: View {
    var user: User
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.profileImage.large)) { image in
                image
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            } placeholder: {
                }
            Text(user.name)
                .navigationTitle(user.getPseudo())
            HStack {
                Image(systemName: "photo")
                Text(String(user.totalPhotos))
            }
            HStack {
                Image(systemName: "heart")
                Text(String(user.totalLikes))
            }
            HStack {
                Image(systemName: "location.circle")
                Text(user.location ?? "Localisation inconnue")
            }
            HStack {
                Image(systemName: "link.circle")
                Link("Compte Unsplash", destination: URL(string: user.links.html)!)
            }
        }
    }
}

//
//  ImageGridView.swift
//  UnsplashApp
//
//  Created by Axel ROUQUETTE on 1/24/24.
//

import SwiftUI

// MARK: ImageGridView

struct ImageGridView: View {
    var data: [UnsplashModel]?
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            if let data {
                ForEach(data, id: \.id) { imageUrl in
                    NavigationLink(destination: SingleImageView(image: imageUrl)) {
                        AsyncImage(url: URL(string: imageUrl.urls.small)) { image in
                            image
                                .centerCropped()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .aspectRatio(contentMode: .fill)

                        } placeholder: {
                            RectanglePlaceholder(color : Color(hex: imageUrl.color))
                        }
                    }
                }
            } else {
                ForEach(0..<12, id: \.self) { index in
                    RectanglePlaceholder(color: Color.init(UIColor.lightGray))
                }
            }
        }
    }
}


// MARK: Rectangle placeholder
struct RectanglePlaceholder: View {
    @State private var opacity = 0
    var color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(color)
            .aspectRatio(contentMode: .fill)
    }
}


// MARK: Color extension
// We are using this extension to cast hexa color to SwiftUI Color.
extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

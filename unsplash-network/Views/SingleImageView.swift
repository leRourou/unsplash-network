//
//  SingleImage.swift
//  UnsplashApp
//
//  Created by Axel ROUQUETTE on 1/24/24.
//

import SwiftUI

enum ImageSize: CaseIterable {
    case small
    case regular
    case full
    
    func getSize(image: UnsplashModel)->String {
        switch self {
        case .full: return image.urls.full
        case .regular: return image.urls.regular
        case .small: return image.urls.small
        }
    }
    
    func getString()->String {
        switch self {
        case .full: return "Full"
        case .regular: return "Regular"
        case .small: return "Small"
        }
    }
}

struct SingleImageView: View {
    var image: UnsplashModel
    @State private var isDownloadAlert = false
    @State var imageSize: ImageSize = ImageSize.regular
    var imageSaver: ImageSaver = ImageSaver()

    var body: some View {
        VStack {
            Text("Image by \(image.user.getPseudo())")
                .font(.title)
                .padding()
            NavigationLink("See \(image.user.getPseudo())'s profile") {
                AuthorView(user: image.user)
            }
            
            // Picker
            Picker("Choose a size", selection: $imageSize) {
                ForEach(ImageSize.allCases, id: \.self) {
                    Text($0.getString())
                }
            }
            .pickerStyle(.palette)
            .padding()
            
            Spacer()
            
            // Image
            AsyncImage(url: URL(string: imageSize.getSize(image: image))) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                RectanglePlaceholder(color: Color(hex: image.color))
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        
        // Download button
        Button(action: {
            downloadImage(imageUrl: imageSize.getSize(image: image))
        }, label: {
            Image(systemName: "square.and.arrow.down")
            Text("Télécharger")
        }).alert(isPresented: $isDownloadAlert) {
            Alert(
                title: Text("Téléchargement terminé"),
                message: Text("L'image a été téléchargée avec succès."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    
    private func downloadImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let downloadedImage = UIImage(data: data)
                imageSaver.saveImage(image: downloadedImage!)
                isDownloadAlert = true
            }
        }.resume()
    }
}

// MARK: Image Saver
class ImageSaver: NSObject {
    func saveImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image saved successfully.")
        }
    }
}

//
//  PhotoMatchupView.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/21/25.
//

import Foundation
import SwiftUI

struct PhotoMatchupView: View {
    let photo1: PhotoItem
    let photo2: PhotoItem
    let onPhoto1Selected: () -> Void
    let onPhoto2Selected: () -> Void
    
    var body: some View {

        HStack(spacing: 15) {
            // Photo 1
            NavigationLink(destination: PhotoDetailView(photo: photo1.image, onPhotoSelected: onPhoto1Selected)) {
                PhotoCardView(image: photo1.image)
            }
            
            Text("VS")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            // Photo 2
            NavigationLink(destination: PhotoDetailView(photo: photo2.image, onPhotoSelected: onPhoto2Selected)) {
                PhotoCardView(image: photo2.image)
            }

        }
    }
}

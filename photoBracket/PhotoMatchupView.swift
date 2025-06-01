//
//  PhotoMatchupView.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/21/25.
//

import Foundation
import SwiftUI

struct PhotoMatchupView: View {
    let photo1: UIImage
    let photo2: UIImage
    let onPhoto1Selected: () -> Void
    let onPhoto2Selected: () -> Void
    
    var body: some View {

        HStack(spacing: 15) {
            // Photo 1
            NavigationLink(destination: PhotoDetailView(photo: photo1, onPhotoSelected: onPhoto1Selected)) {
                PhotoCardView(image: photo1)
            }
            
            Text("VS")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            // Photo 2
            NavigationLink(destination: PhotoDetailView(photo: photo2, onPhotoSelected: onPhoto2Selected)) {
                PhotoCardView(image: photo2)
            }

        }
    }
}

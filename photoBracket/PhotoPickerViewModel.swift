//
//  PhotoPickerViewModel.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/21/25.
//

import Foundation
import SwiftUI
import PhotosUI

class PhotoPickerViewModel: ObservableObject {
    @Published var selectedItems: [PhotosPickerItem] = []
    @Published var images: [UIImage] = []
    
    func loadImages(from items: [PhotosPickerItem]) {
        Task {
            var newImages: [UIImage] = []
            for item in items {
                do {
                    if let data = try await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        newImages.append(image)
                    }
                } catch {
                    print("error loeading image data: \(error)")
                }
            }
            self.images = newImages
        }
    }
}

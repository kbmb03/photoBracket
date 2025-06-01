//
//  photoDetailView.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/31/25.
//

import SwiftUI
import UIKit

// A UIViewRepresentable wrap for UIScrollView + UIImageView to enable zooming and panning.
struct ZoomableScrollView: UIViewRepresentable {
    let image: UIImage

    func makeUIView(context: Context) -> UIScrollView {
        // UIScrollView container
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        // UIImageView that displays the image
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.frame = scrollView.bounds

        // Ensure the imageView resizes with scrollView
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.addSubview(imageView)
        context.coordinator.imageView = imageView

        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // Reset zoom scale when updating
        if let imageView = context.coordinator.imageView {
            imageView.image = image
            imageView.frame = uiView.bounds
            uiView.zoomScale = 1.0
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        weak var imageView: UIImageView?

        // Tell the scroll view which view to zoom
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imageView
        }

        // Center the imageView as it zooms out
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            guard let imageView = imageView else { return }
            let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0)
            let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0)
            imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX,
                                       y: scrollView.contentSize.height * 0.5 + offsetY)
        }
    }
}



struct PhotoDetailView: View {
    let photo: UIImage
    let onPhotoSelected: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            VStack(spacing: 0) {
                
                ZoomableScrollView(image: photo)
                    .edgesIgnoringSafeArea(.top)

                Button {
                    onPhotoSelected()
                    dismiss()
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                        .padding(.bottom, 30)
                }
            }
        .navigationBarTitleDisplayMode(.inline)
    }
}

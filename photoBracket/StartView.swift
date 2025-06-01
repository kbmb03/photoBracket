//
//  StartView.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/21/25.
//

import Foundation
import SwiftUI

struct StartView: View {
    @ObservedObject var viewModel: TournamentViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "camera.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Photo Tournament!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Select up to 50 photos and let them battle it out in a head-to-head tournament!")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            if viewModel.isLoading {
                ProgressView("Loading photos...")
            } else {
                Button("Start Tournament") {
                    viewModel.startPhotoPicker()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            
            Spacer()
        }
        .alert("Insufficient Photos", isPresented: $viewModel.insufficientPhotos) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please pick at least two photos to begin the tournament.")
        }
    }
}

//
//  ContentView.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/21/25.
//


import PhotosUI
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TournamentViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                switch viewModel.gameState {
                case .start:
                    StartView(viewModel: viewModel)
                case .playing:
                    MatchupView(viewModel: viewModel)
                case .finished:
                    WinnerView(viewModel: viewModel)
                }
            }
            .padding()
        }
        .photosPicker(isPresented: $viewModel.showingPhotoPicker,
                     selection: Binding<[PhotosPickerItem]>(
                        get: { [] },
                        set: { items in
                            viewModel.loadPhotos(from: items)
                        }
                     ),
                     matching: .images)
    }
}

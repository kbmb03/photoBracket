//
//  WinnerView.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/21/25.
//

import Foundation
import SwiftUI

struct WinnerView: View {
    @ObservedObject var viewModel: TournamentViewModel
    
    var body: some View {
        let winner = viewModel.tournament?.winner
        VStack(spacing: 30) {
            Text("🏆 WINNER! 🏆")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            if let winner = winner {
                WinnerPhotoView(image: winner.image)
            }
            
            Button("Start New Tournament") {
                viewModel.resetTournament()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.green)
            
            if let winner = winner, let winnerID = winner.assetID {
                Button {
                    print("Added to favorites \(winnerID)")
                } label: {
                    HStack {
                        Text("Add Photo to Favorites")
                        Image(systemName: "heart.fill")
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.blue)
            }
            Spacer()
        }
    }
}

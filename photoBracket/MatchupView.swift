//
//  MatchupView.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/21/25.
//

import Foundation
import SwiftUI

struct MatchupView: View {
    @ObservedObject var viewModel: TournamentViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            if let tournament = viewModel.tournament {
                // Round indicator
                Text("Round \(tournament.currentRound) of \(tournament.totalRounds)")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text("Tap the photo you prefer!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Photo matchup
                if let match = tournament.currentMatch {
                    PhotoMatchupView(
                        photo1: match.0,
                        photo2: match.1,
                        onPhoto1Selected: { viewModel.selectWinner(match.0) },
                        onPhoto2Selected: { viewModel.selectWinner(match.1) }
                    )
                }
                
                // Tournament progress
                Text("\(tournament.remainingPhotos.count) photos remaining")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

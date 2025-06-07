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
        VStack(spacing: 30) {
            Text("🏆 WINNER! 🏆")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            if let winner = viewModel.tournament?.winner {
                WinnerPhotoView(image: winner.image)
            }
            
            Button("Start New Tournament") {
                viewModel.resetTournament()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.green)
            
            Spacer()
        }
    }
}

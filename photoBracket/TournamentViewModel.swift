//
//  TournamentViewModel.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/21/25.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class TournamentViewModel: ObservableObject {
    @Published var tournament: Tournament?
    @Published var showingPhotoPicker = false
    @Published var isLoading = false
    @Published var insufficientPhotos = false
    
    var gameState: GameState {
        guard let tournament = tournament else { return .start }
        
        if tournament.isComplete {
            return .finished
        } else if tournament.currentMatch != nil {
            return .playing
        } else {
            return .start
        }
    }
    
    func startPhotoPicker() {
        showingPhotoPicker = true
    }
    
    func loadPhotos(from items: [PhotosPickerItem]) {
        isLoading = true
        var loadedPhotos: [UIImage] = []
        
        let group = DispatchGroup()
        
        for item in items {
            group.enter()
            item.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        if let data = data, let image = UIImage(data: data) {
                            loadedPhotos.append(image)
                        }
                    case .failure(let error):
                        print("Error loading photo: \(error)")
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
            if loadedPhotos.count == 1 {
                self.insufficientPhotos = true
                print("please select at least two photos to begin tournament. ")
            }
            if loadedPhotos.count > 1 {
                self.startTournament(with: loadedPhotos)
            }
        }
    }
    
    func selectWinner(_ winner: UIImage) {
        tournament?.selectWinner(winner)
    }
    
    func resetTournament() {
        tournament = nil
    }
    
    private func startTournament(with photos: [UIImage]) {
        tournament = Tournament(photos: photos)
    }
}

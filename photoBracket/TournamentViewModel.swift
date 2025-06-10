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
        var loadedPhotos: [PhotoItem] = []
        
        let group = DispatchGroup()
        
        for item in items {
            group.enter()
            let id = item.itemIdentifier
            item.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        if let data = data, let image = UIImage(data: data) {
                            loadedPhotos.append(PhotoItem(image: image, assetID: id))
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
    
    func addToFavorites(assetID: String) {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            guard status == .authorized || status == .limited else {
                return
            }
            let assets = PHAsset.fetchAssets(withLocalIdentifiers: [assetID], options: nil)
            guard let asset = assets.firstObject else {
                return
            }
            let favAlbum = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil)
                .firstObject
            guard let album = favAlbum else { return }
            PHPhotoLibrary.shared().performChanges {
                PHAssetCollectionChangeRequest(for: album)?
                    .addAssets([asset] as NSArray)
            }
        }
    }
    
    func selectWinner(_ winner: PhotoItem) {
        tournament?.selectWinner(winner)
    }
    
    func resetTournament() {
        tournament = nil
    }
    
    private func startTournament(with photos: [PhotoItem]) {
        tournament = Tournament(photos: photos)
    }
}

//
//  Tournament.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/21/25.
//

import Foundation
import UIKit

struct Tournament {
    private(set) var photos: [UIImage]
    private(set) var remainingPhotos: [UIImage]
    private(set) var currentRound: Int
    private(set) var totalRounds: Int
    private(set) var isComplete: Bool
    
    var winner: UIImage? {
        isComplete ? remainingPhotos.first : nil
    }
    
    var currentMatch: (UIImage, UIImage)? {
        guard remainingPhotos.count >= 2, !isComplete else { return nil }
        return (remainingPhotos[0], remainingPhotos[1])
    }
    
    init(photos: [UIImage]) {
        self.photos = photos.shuffled()
        self.remainingPhotos = self.photos
        self.currentRound = 1
        self.totalRounds = Self.calculateTotalRounds(photoCount: photos.count)
        self.isComplete = photos.count <= 1
    }
    
    mutating func selectWinner(_ winner: UIImage) {
        remainingPhotos.removeFirst(2)
        remainingPhotos.append(winner)
        updateRoundIfNeeded()
        // Check if tournament is complete
        if remainingPhotos.count <= 1 {
            isComplete = true
        }
    }
    
    private mutating func updateRoundIfNeeded() {
        let nextPowerOfTwo = Int(pow(2, ceil(log2(Double(remainingPhotos.count)))))
        if remainingPhotos.count == nextPowerOfTwo && remainingPhotos.count < photos.count {
            currentRound += 1
        }
    }
    
    private static func calculateTotalRounds(photoCount: Int) -> Int {
        guard photoCount > 1 else { return 0 }
        return Int(ceil(log2(Double(photoCount))))
    }
}

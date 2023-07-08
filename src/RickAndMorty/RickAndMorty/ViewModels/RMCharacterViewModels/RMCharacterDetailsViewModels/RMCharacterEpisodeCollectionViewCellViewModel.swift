//
//  RMCharacterEpisodeCollectionViewCellModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 8/7/2023.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodeId: Int
    
    init (episodeUrl: URL?) {
        // bad handling but i want to extract the episode id from url
        self.episodeId = Int(episodeUrl?.lastPathComponent ?? "") ?? -1
    }
    
}

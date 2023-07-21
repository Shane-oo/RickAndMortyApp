//
//  RMEpisodesResonseModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 21/7/2023.
//

import Foundation

final class RMEpisodesResponseModel: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisodeModel]
}

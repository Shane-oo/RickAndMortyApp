//
//  RMEpisodeModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 1/7/2023.
//

import Foundation

struct RMEpisodeModel: Codable, RMEpisodeDataRender {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

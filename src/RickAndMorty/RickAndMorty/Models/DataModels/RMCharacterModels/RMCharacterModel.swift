//
//  RMCharacterModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 1/7/2023.
//

import Foundation

struct RMCharacterModel: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatusModel
    let species: String
    let type: String
    let gender: RMCharacterGenderModel
    let origin: RMCharacterOriginModel
    let location: RMCharacterLocationModel
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

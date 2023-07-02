//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    // avoid keyword with back ticks
    case `unkown` = "unkown"
}

//
//  RMCharacterStatusModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import Foundation

enum RMCharacterStatusModel: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    // avoid keyword with back ticks
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}

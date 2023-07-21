//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import Foundation


/// Represents unique API endpoints
@frozen enum RMEndpoint: String, CaseIterable, Hashable {
    case character // "character"
    case location // "location"
    case episode // "episode"
}

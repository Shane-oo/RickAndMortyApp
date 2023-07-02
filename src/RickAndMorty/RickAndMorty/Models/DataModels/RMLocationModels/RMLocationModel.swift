//
//  RMLocationModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 1/7/2023.
//

import Foundation

struct RMLocationModel: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

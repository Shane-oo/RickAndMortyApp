//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacterModel
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    // MARK: - Init
    
    init(character: RMCharacterModel) {
        self.character = character
    }
    

    public var title: String {
        character.name.uppercased()
    }
}

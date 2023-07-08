//
//  RMCharacterInfoCollectionViewCellModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 8/7/2023.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    public let value: String
    public let title: String
    
    init(value:String, title: String) {
        self.value = value
        self.title = title
    }

}

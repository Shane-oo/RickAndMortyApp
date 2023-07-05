//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    public let characterName: String
    private let characterStatus: RMCharacterStatusModel
    private let characterImageURL: URL?
    
    
    //  MARK: - Init
    
    init(characterName: String,
         characterStatus: RMCharacterStatusModel,
         characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageUrl
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {        
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
       
        RMImageManager.shared.downloadImage(url, completion: completion)

    }
    
    
    // MARK: - Hashable
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel,
                    rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
}

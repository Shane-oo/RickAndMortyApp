//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {

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
        // TODO: Abstract to image manager

        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}

//
//  RMCharacterPhotoCollectionViewCellModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 8/7/2023.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    private let imageUrl: URL?
    
    init(imageUrl:URL?) {
        self.imageUrl = imageUrl
    }
    

    
    public func fetchImage(completion: @escaping (Result<Data,Error>) -> Void) {
        
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        RMImageManager.shared.downloadImage(imageUrl, completion: completion)
    }
}

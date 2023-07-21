//
//  RMCharacterEpisodeCollectionViewCellModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 8/7/2023.
//

import Foundation

// publish and subscribe pattern
protocol RMEpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel: Hashable, Equatable {

    
    private let episodeId: String
    
    private var isFetching = false
    
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    
    private var episode: RMEpisodeModel? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    public var episodeRequest : RMRequestBuilder {
        return RMRequestBuilder(endpoint: .episode,
        pathComponents: [episodeId])
    }
    // MARK: - Init
    
    init (episodeUrl: URL?) {
        guard let episodeId = episodeUrl?.lastPathComponent else {
            self.episodeId = ""
            return
        }
        self.episodeId = episodeId
    }
    
    // MARK: - Public
    
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void){
        self.dataBlock = block
    }
    
    public func fetchEpisode(){
        guard !isFetching else {
            // if we have it already give it back with publish
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        
        isFetching = true
        
        RMService.shared.execute(
            episodeRequest,
            expecting: RMEpisodeModel.self
        ) { [weak self] result in
            switch result {
            case .success(let response):
                
                DispatchQueue.main.async {
                    self?.episode = response
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeId)
    }
    
    static func == (lhs: RMCharacterEpisodeCollectionViewCellViewModel, rhs: RMCharacterEpisodeCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

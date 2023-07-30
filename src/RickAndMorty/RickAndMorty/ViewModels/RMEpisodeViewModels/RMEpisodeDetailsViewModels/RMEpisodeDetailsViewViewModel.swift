//
//  RMEpisodeDetailsViewViewModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 21/7/2023.
//

import UIKit

protocol RMEpisodeDetailsViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
    
}

final class RMEpisodeDetailsViewViewModel {
    private let episodeId: String;
    private var dataTuple: (RMEpisodeModel, [RMCharacterModel])? {
        didSet {
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    public weak var delegate: RMEpisodeDetailsViewViewModelDelegate?
    

    

    

    public var episodeRequest : RMRequestBuilder {
        return RMRequestBuilder(endpoint: .episode,
        pathComponents: [episodeId])
    }
    
    // MARK: - Init
    
    init(episodeUrl: URL?) {
        guard let episodeId = episodeUrl?.lastPathComponent else {
            self.episodeId = ""
            return
        }
        self.episodeId = episodeId
    }
    // Mark: - Public
    
    /// Fetch backing episode model
    public func fetchEpisodeData(){
        RMService.shared.execute(
            episodeRequest,
            expecting: RMEpisodeModel.self
        ) { [weak self] result in
            switch result {
            case .success(let response):
                self?.fetchRelatedCharacters(episode: response)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    
    // Mark: - Private
    

    
    private func fetchRelatedCharacters(episode: RMEpisodeModel) {
        let requests: [RMRequestBuilder] = episode.characters.compactMap({
            return URL(string: $0)?.lastPathComponent ?? "-1"
        }).compactMap({
            return RMRequestBuilder(endpoint: .character,
                                    pathComponents: [$0])
        })
        
        // Dispatch group
        // n of parrelel requests
        // we get notified once all done
        
        let group = DispatchGroup()
        var characters: [RMCharacterModel] = []
        for request in requests {
            group.enter() // +20
            RMService.shared.execute(request, expecting: RMCharacterModel.self)
            { result in
                
                defer {
                    group.leave() // --
                }
                
                switch result {
                case .success(let response):
                    characters.append(response)
                case .failure:
                    break
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (
                episode,
                characters
            )
        }
    }
    
}

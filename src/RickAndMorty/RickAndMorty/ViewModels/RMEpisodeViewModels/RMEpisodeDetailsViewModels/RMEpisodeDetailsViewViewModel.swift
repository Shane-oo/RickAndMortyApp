//
//  RMEpisodeDetailsViewViewModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 21/7/2023.
//

import UIKit

class RMEpisodeDetailsViewViewModel {
    private let episodeId: String;
    
    public var episodeRequest : RMRequestBuilder {
        return RMRequestBuilder(endpoint: .episode,
        pathComponents: [episodeId])
    }
    
    init(episodeUrl: URL?) {
        guard let episodeId = episodeUrl?.lastPathComponent else {
            self.episodeId = ""
            return
        }
        self.episodeId = episodeId
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData(){
        RMService.shared.execute(
            episodeRequest,
            expecting: RMEpisodeModel.self
        ) { [weak self] result in
            switch result {
            case .success(let response):
                
                print(String(describing: response))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

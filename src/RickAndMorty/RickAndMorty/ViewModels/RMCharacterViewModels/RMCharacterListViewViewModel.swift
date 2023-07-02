//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import Foundation

struct RMCharacterListViewViewModel {
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponseModel.self) { result in
            switch result {
            case .success(let model):
                print("Total: " + String(model.info.count))
                print("Page result count: " + String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

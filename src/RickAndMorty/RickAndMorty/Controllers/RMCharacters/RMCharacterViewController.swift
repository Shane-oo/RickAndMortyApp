//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Shane Monck on 1/7/2023.
//

import UIKit

/// Controller to show and search for characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let requset = RMRequest(endpoint: .character,
                                pathComponents: ["1"],
                                queryParameters: [
                                        URLQueryItem(name: "name", value: "rick")
                                    ]
        )
        print(requset.url)
        
        RMService.shared.execute(requset, expecting: RMCharacter.self) { result in

        }
    }

}

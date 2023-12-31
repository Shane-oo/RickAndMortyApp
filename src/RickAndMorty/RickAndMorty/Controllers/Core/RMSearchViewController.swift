//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Shane Monck on 23/7/2023.
//

import UIKit

/// Configuratble Controller to search
final class RMSearchViewController: UIViewController {

    struct Config {
        enum `Type` {
            case character
            case episode
            case location
        }
        let type: `Type`
    }
    private let config: Config
    
    init(config: Config){
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemPink
    }
    



}

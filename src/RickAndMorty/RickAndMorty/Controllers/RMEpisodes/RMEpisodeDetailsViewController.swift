//
//  RMEpisodeDetailsViewController.swift
//  RickAndMorty
//
//  Created by Shane Monck on 9/7/2023.
//

import UIKit

/// View Controller to show details about a single episode
final class RMEpisodeDetailsViewController: UIViewController {
    private let url: URL?
    
    // MARK: - Init
    
    init(url: URL?){
        self.url = url
        print(String(describing: url))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemGreen
    }
    

}

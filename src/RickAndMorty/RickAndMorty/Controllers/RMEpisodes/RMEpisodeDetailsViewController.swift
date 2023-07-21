//
//  RMEpisodeDetailsViewController.swift
//  RickAndMorty
//
//  Created by Shane Monck on 9/7/2023.
//

import UIKit

/// View Controller to show details about a single episode
final class RMEpisodeDetailsViewController: UIViewController {
    private let viewModel: RMEpisodeDetailsViewViewModel
    
    
    // MARK: - Init
    
    init(url: URL?){
        
        self.viewModel = .init(episodeUrl: url)
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

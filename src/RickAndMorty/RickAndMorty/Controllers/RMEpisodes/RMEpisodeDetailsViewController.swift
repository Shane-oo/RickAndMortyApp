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
    
    private let detailView = RMEpisodeDetailsView()
    
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
        view.addSubview(detailView)

        addConstraints()
        title = "Episode"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare))
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func didTapShare(){
        
    }
    

}

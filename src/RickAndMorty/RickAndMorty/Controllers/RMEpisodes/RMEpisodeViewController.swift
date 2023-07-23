//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Shane Monck on 1/7/2023.
//

import UIKit

/// Controller to show and search for episodes
final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {

    private let episodeListView = RMEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Episodes"
        setUpView()
        addSearchButton()
    }
    
    
    private func setUpView(){
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        
        // pin this view to the top, left, right and bottom
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            episodeListView.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor
            ),
            episodeListView.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor
            ),
            episodeListView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch(){
        
    }
    
    // MARK: - RMEpisodeListViewDelegate
    
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView,
                             didSelectEpisode episode: RMEpisodeModel) {
        // Open detail controller for that episode
        let detailVC = RMEpisodeDetailsViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
        
    }

}

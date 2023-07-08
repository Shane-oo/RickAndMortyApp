//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Shane Monck on 1/7/2023.
//

import UIKit

/// Controller to show and search for characters
final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {

    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
        
        
        
    }
    
    private func setUpView(){
        characterListView.delegate = self
        view.addSubview(characterListView)
        
        // pin this view to the top, left, right and bottom
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            characterListView.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor
            ),
            characterListView.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor
            ),
            characterListView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
    
    // MARK: - RMCharacterListViewDelegate
    
    func rmCharacterListView(_ characterListView: RMCharacterListView,
                             didSelectCharacter character: RMCharacterModel) {
        // Open detail controller for that character
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
        
    }

}

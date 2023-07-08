//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import UIKit


/// Controller to show info about single character
final class RMCharacterDetailViewController: UIViewController {
    private let detailView = RMCharacterDetailView();

    private let viewModel: RMCharacterDetailViewViewModel
    
    // MARK: - Init
    
    init(viewModel: RMCharacterDetailViewViewModel){
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        
        addConstraints()
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }

    
    @objc
    private func didTapShare(){
        //todo
        // Share character info
    }
    
    private func addConstraints(){
        // pin every corner of the view to the safe layout guide
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// adding UICollectionViewDelegate and UIcollectionViewDataSouce in controller
// instead of view model where it is for charactersList
// I will determine which one i like

// MARK: - CollectionView
extension RMCharacterDetailViewController: UICollectionViewDelegate {
    
}

extension RMCharacterDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int)
    -> Int {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath)
        cell.backgroundColor = .systemPink
        return cell
    }
}

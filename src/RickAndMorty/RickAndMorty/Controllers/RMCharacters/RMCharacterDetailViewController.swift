//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import UIKit


/// Controller to show info about single character
final class RMCharacterDetailViewController: UIViewController {
    private let detailView: RMCharacterDetailsView

    private let viewModel: RMCharacterDetailsViewViewModel
    
    // MARK: - Init
    
    init(viewModel: RMCharacterDetailsViewViewModel){
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailsView(frame: .zero,
                                                viewModel: viewModel)

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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo, .information:
            break
        case .episodes:
            let episodes = self.viewModel.character.episode
            let selection = episodes[indexPath.row]
            let vc = RMEpisodeDetailsViewController(url: URL(string: selection))
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension RMCharacterDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int)
    -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
            
        case .photo:
            return 1
        case .information(viewModels: let viewModels):
            return viewModels.count
        case .episodes(viewModels: let viewModels):
            return viewModels.count
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            
        case .photo(viewModel: let viewModel):
            guard  let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier,
                for: indexPath)
                    as? RMCharacterPhotoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)

            return cell
        case .information(viewModels: let viewModels):
            guard  let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier,
                for: indexPath)
                    as? RMCharacterInfoCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: viewModels[indexPath.row])

            return cell
        case .episodes(viewModels: let viewModels):
            guard  let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
                for: indexPath)
                    as? RMCharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])

            return cell
        }
        
        
    }
}

//
//  RMEpisodeDetailsView.swift
//  RickAndMorty
//
//  Created by Shane Monck on 21/7/2023.
//

import UIKit

final class RMEpisodeDetailsView: UIView {
    
    private var viewModel: RMEpisodeDetailsViewViewModel?
    
    private var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }
    // MARK: - Init
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        self.collectionView = createCollectionView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
        ])
    }

    private func createCollectionView() -> UICollectionView {
        
    }
    
    // MARK: - Public
    
    public func configure(with viewModel: RMEpisodeDetailsViewViewModel){
        self.viewModel = viewModel
    }
    
}

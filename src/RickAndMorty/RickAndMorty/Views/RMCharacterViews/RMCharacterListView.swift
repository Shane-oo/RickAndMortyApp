//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import UIKit


/// View That handles showing list of characters, loader, etc...
final class RMCharacterListView: UIView {
    
    private let viewModel = RMCharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    
    // MARK - Init
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        // add spinner subview
        addSubview(spinner)
        addConstraints()
        
        spinner.startAnimating()
        
        viewModel.fetchCharacters()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

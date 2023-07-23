//
//  RMEpisodeDetailsView.swift
//  RickAndMorty
//
//  Created by Shane Monck on 21/7/2023.
//

import UIKit

final class RMEpisodeDetailsView: UIView {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
}

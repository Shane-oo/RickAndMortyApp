//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemCyan
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints(){
        
    }
}

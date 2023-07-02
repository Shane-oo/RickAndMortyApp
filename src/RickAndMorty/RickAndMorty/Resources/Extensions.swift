//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

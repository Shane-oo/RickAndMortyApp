//
//  RMCharacterInfoCollectionViewCellModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 8/7/2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    static let dateFormatter: DateFormatter = {
       let formmatter = DateFormatter()
        formmatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formmatter.timeZone = .current
        
        return formmatter
    }()

    static let shortDateFormatter: DateFormatter = {
       let formmatter = DateFormatter()
        formmatter.dateStyle = .medium
        formmatter.timeStyle = .short

        return formmatter
    }()

    
    private let cellType: CellType
    private let value: String
    
    public var title: String {
        self.cellType.displayTitle
    }
    public var displayValue: String {
        if value.isEmpty { return "None" }
        
        if let date = Self.dateFormatter.date(from: value),
            cellType == .created {
           
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    
    public var iconImage: UIImage? {
        return cellType.icomImage
    }
    
    public var tintColour: UIColor {
        return cellType.tintColour
    }
    
    enum CellType: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColour: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemPink
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            case .created:
                return .systemMint
            case .location:
                return .systemBrown
            case .episodeCount:
                return .systemIndigo
            }
        }
        
        var icomImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "heart")
            case .gender:
                return UIImage(systemName: "figure.dress.line.vertical.figure")
            case .type:
                return UIImage(systemName: "tray")
            case .species:
                return UIImage(systemName: "pawprint")
            case .origin:
                return UIImage(systemName: "house")
            case .created:
                return UIImage(systemName: "figure.child")
            case .location:
                return UIImage(systemName: "location")
            case .episodeCount:
                return UIImage(systemName: "videoprojector")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status,
                    .gender,
                    .type,
                    .species,
                    .origin,
                    .created,
                    .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
    init(cellType: CellType, value: String) {
        self.value = value
        self.cellType = cellType
    }
    
}

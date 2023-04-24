//
//  RMCharacterDetailInformationUIModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 4/24/23.
//

import Foundation
import UIKit

struct RMCharacterDetailInformationUIModel {
    let text: String
    let type: `Type`
    
    enum `Type` {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var displayTitle: String {
            switch self {
            case .status:
                return "Status"
            case .gender:
                return "Gender"
            case .type:
                return "Type"
            case .species:
                return "Species"
            case .origin:
                return "Origin"
            case .created:
                return "Created"
            case .location:
                return "Location"
            case .episodeCount:
                return "Episodes"
            }
        }
        
        var color: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemOrange
            case .type:
                return .systemPurple
            case .species:
                return .systemPink
            case .origin:
                return .systemYellow
            case .created:
                return .systemCyan
            case .location:
                return .systemGray
            case .episodeCount:
                return .black
            }
        }
    }
}

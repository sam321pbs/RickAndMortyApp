//
//  RMCharacterStatus.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 4/24/23.
//

import Foundation

enum RMCharacterStatus: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}

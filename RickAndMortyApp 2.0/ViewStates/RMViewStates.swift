//
//  RMViewStates.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 4/24/23.
//

import Foundation

enum RMViewState: Equatable {
    
    case initial
    case loading
    case success
    case error(Error)
    
    static func == (lhs: RMViewState, rhs: RMViewState) -> Bool {
        switch (lhs, rhs) {
        case (let .initial, let .initial):
            return true
        case (.loading, .loading):
            return true
        case (.success, .success):
            return true
        case (let .error(error1), let .error(error2)):
            return true
        default:
            return false
        }
    }
}

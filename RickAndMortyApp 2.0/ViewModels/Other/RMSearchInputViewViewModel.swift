//
//  RMSearchInputViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/1/23.
//

import Foundation

final class RMSearchInputViewViewModel {
    private var type: RMSearchViewController.Config.`Type`?
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
    }
    
    public var hasDynamicOptions: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode, .none:
            return false
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .location:
            return [.locationType]
        case .episode, .none:
            return []
        }
    }
    
    public var searchPlaceholderText: String {
        switch self.type {
        case .character:
            return "Character Name"
        case .location:
            return "Location Name"
        case .episode, .none:
            return "Episode Title"
        }
    }
    
    // MARK: - Init
    
    init(type: RMSearchViewController.Config.`Type`?) {
        self.type = type
    }
}

//
//  RMSettingsViewViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import Foundation

final class RMSettingsViewViewModel {
    
    var onTapHandler: ((RMSettingsOption) -> Void)?
    
    var settingsOptions: [RMSettingsOption] {
        return RMSettingsOption.allCases
    }
    
    // MARK: - Public
    
    func setTapHandler(onTap: @escaping (RMSettingsOption) -> Void) {
        self.onTapHandler = onTap
    }
    
    func onTappedView(setting: RMSettingsOption) {
        if let handler = onTapHandler {
            handler(setting)
        }
    }
}

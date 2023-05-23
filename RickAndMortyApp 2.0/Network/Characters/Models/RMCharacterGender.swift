//
//  RMCharacterGender.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 4/24/23.
//

import Foundation

enum RMCharacterGender: String, Codable, CaseIterable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
}

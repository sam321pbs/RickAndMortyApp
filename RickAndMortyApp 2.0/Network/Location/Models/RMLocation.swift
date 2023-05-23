//
//  RMLocation.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 4/24/23.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

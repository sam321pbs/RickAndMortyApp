//
//  RMEpisode.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 4/24/23.
//

import Foundation

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

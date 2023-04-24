//
//  RMGetEpisodesResponse.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 4/24/23.
//

import Foundation

struct RMGetEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int?
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
}

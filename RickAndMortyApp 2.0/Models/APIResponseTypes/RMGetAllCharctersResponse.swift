//
//  RMGetCharctersResponse.swift
//  Rick and Morty App
//
//  Created by Samuel Mengistu on 1/18/23.
//

import Foundation

struct RMGetAllCharctersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}

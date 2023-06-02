//
//  MockedRMCharactersRepository.swift
//  RickAndMortyAppUnitTests
//
//  Created by Samuel Mengistu on 6/2/23.
//

import Foundation

final class MockedRMCharactersRepository: RMCharactersRepository {
    func getCharactersByPage(page: Int) async throws -> RMCharactersResponse {
        return charactersResponse
    }
    
    func getCharactersByIds(ids: [Int]) async throws -> [RMCharacter] {
        return [character]
    }
    
    func getCharactersById(id: Int) async throws -> RMCharacter {
        return character
    }
    
    func getCharactersWithFilters(name: String?, status: RMCharacterStatus?, gender: RMCharacterGender?) async throws -> RMCharactersResponse {
        return charactersResponse
    }
}

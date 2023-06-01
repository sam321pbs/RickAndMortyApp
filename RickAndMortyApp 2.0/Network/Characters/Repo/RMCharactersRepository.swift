//
//  CharactersRepositories.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

protocol RMCharactersRepository {
    func getCharactersByPage(page: Int) async throws -> RMCharactersResponse
    func getCharactersByIds(ids: [Int]) async throws -> [RMCharacter]
    func getCharactersById(id: Int) async throws -> RMCharacter
    func getCharactersWithFilters(
        name: String?,
        status: RMCharacterStatus?,
        gender: RMCharacterGender?
    ) async throws -> RMCharactersResponse
}

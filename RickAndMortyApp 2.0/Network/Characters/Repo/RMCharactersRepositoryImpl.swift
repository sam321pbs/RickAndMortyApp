//
//  RMCharactersRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

struct RMCharactersRepositoryImpl: RMCharactersRepository {
    
    let dataSouce: RMCharactersDataSource
    
    func getCharactersByPage(page: Int) async throws -> RMCharactersResponse {
        return try await dataSouce.getCharactersByPage(page: page)
    }
    
    func getCharactersByIds(ids: [Int]) async throws -> [RMCharacter] {
        return try await dataSouce.getCharactersByIds(ids: ids)
    }
    
    func getCharactersById(id: Int) async throws -> RMCharacter {
        return try await dataSouce.getCharacterById(id: id)
    }
    
    func getCharactersWithFilters(name: String?, status: RMCharacterStatus?, gender: RMCharacterGender?) async throws -> RMCharactersResponse {
        return try await dataSouce.getCharactersWithFilters(name: name, status: status, gender: gender)
    }
}

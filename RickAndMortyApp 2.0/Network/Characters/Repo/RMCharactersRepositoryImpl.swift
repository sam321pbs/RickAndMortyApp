//
//  RMCharactersRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

final class RMCharactersRepositoryImpl: RMCharactersRepository {
    
    @Injected(\.charactersRemoteDataSource) private var dataSource: RMCharactersDataSource
    
    func getCharactersByPage(page: Int) async throws -> RMCharactersResponse {
        return try await dataSource.getCharactersByPage(page: page)
    }
    
    func getCharactersByIds(ids: [Int]) async throws -> [RMCharacter] {
        return try await dataSource.getCharactersByIds(ids: ids)
    }
    
    func getCharactersById(id: Int) async throws -> RMCharacter {
        return try await dataSource.getCharacterById(id: id)
    }
    
    func getCharactersWithFilters(name: String?, status: RMCharacterStatus?, gender: RMCharacterGender?) async throws -> RMCharactersResponse {
        return try await dataSource.getCharactersWithFilters(name: name, status: status, gender: gender)
    }
}

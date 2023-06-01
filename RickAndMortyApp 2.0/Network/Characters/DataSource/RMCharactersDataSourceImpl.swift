//
//  RMGetAllCharactersDataSourceImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

struct RMCharactersDataSourceImpl: RMCharactersDataSource {

    func getCharacterById(id: Int) async throws -> RMCharacter {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getCharactersByIdsDataRequest(ids: [id]))
    }
    
    func getCharactersByIds(ids: [Int]) async throws -> [RMCharacter] {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getCharactersByIdsDataRequest(ids: ids))
    }
    
    func getCharactersByPage(page: Int) async throws -> RMCharactersResponse {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getCharactersByPageDataRequest(page: page))
    }
    
    func getCharactersWithFilters(
        name: String?,
        status: RMCharacterStatus?,
        gender: RMCharacterGender?
    ) async throws -> RMCharactersResponse {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getCharactersWithFiltersDataRequest(name: name, status: status, gender: gender))
    }
}

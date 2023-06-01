//
//  RMEpisodesDataSourceImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

struct RMEpisodesRemoteDataSourceImpl: RMEpisodesRemoteDataSource {

    func getEpisodeById(id: Int) async throws -> RMEpisode {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getEpisodesByIdsDataRequest(ids: [id]))
    }
    
    func getEpisodesByIds(ids: [Int]) async throws -> [RMEpisode] {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getEpisodesByIdsDataRequest(ids: ids))
    }
        
    func getEpisodesByPage(page: Int) async throws -> RMEpisodesResponse {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getEpisodesByPageDataRequest(page: page))
    }
    
    func getEpisodesWithFilters(name: String?) async throws -> RMEpisodesResponse {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getEpisodesWithFiltersDataRequest(name: name))
    }
}

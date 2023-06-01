//
//  RMEpisodesRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

struct RMEpisodesRepositoryImpl: RMEpisodesRepository {
    
    @Injected(\.episodesRemoteDataSource) private var dataSource: RMEpisodesRemoteDataSource
    
    func getEpisodeById(id: Int) async throws -> RMEpisode {
        return try await dataSource.getEpisodeById(id: id)
    }
    
    func getEpisodesByPage(page: Int) async throws -> RMEpisodesResponse {
        return try await dataSource.getEpisodesByPage(page: page)
    }
    
    func getEpisodesByIds(ids: [Int]) async throws -> [RMEpisode] {
        return try await dataSource.getEpisodesByIds(ids: ids)
    }
    
    func getEpisodesWithFilters(name: String?) async throws -> RMEpisodesResponse {
        return try await dataSource.getEpisodesWithFilters(name: name)
    }
}

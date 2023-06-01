//
//  RMEpisodesRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

struct RMEpisodesRepositoryImpl: RMEpisodesRepository {
    
    let dataSouce: RMEpisodesDataSource
    
    func getEpisodeById(id: Int) async throws -> RMEpisode {
        return try await dataSouce.getEpisodeById(id: id)
    }
    
    func getEpisodesByPage(page: Int) async throws -> RMEpisodesResponse {
        return try await dataSouce.getEpisodesByPage(page: page)
    }
    
    func getEpisodesByIds(ids: [Int]) async throws -> [RMEpisode] {
        return try await dataSouce.getEpisodesByIds(ids: ids)
    }
    
    func getEpisodesWithFilters(name: String?) async throws -> RMEpisodesResponse {
        return try await dataSouce.getEpisodesWithFilters(name: name)
    }
}

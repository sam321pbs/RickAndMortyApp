//
//  MockedRMEpisodesRepository.swift
//  RickAndMortyAppUnitTests
//
//  Created by Samuel Mengistu on 6/2/23.
//

import Foundation

final class MockedRMEpisodesRepository: RMEpisodesRepository {
    func getEpisodesByPage(page: Int) async throws -> RMEpisodesResponse {
        return dummyEpisodeResponse
    }
    
    func getEpisodesByIds(ids: [Int]) async throws -> [RMEpisode] {
        return [dummyEpisode]
    }
    
    func getEpisodeById(id: Int) async throws -> RMEpisode {
        return dummyEpisode
    }
    
    func getEpisodesWithFilters(name: String?) async throws -> RMEpisodesResponse {
        return dummyEpisodeResponse
    }
}

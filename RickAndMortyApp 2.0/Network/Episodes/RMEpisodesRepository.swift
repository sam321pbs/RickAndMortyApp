//
//  RMEpisodesRepository.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

protocol RMEpisodesRepository {
    func getEpisodesByPage(page: Int) async throws -> RMEpisodesResponse
    func getEpisodesByIds(ids: [Int]) async throws -> [RMEpisode]
    func getEpisodeById(id: Int) async throws -> RMEpisode
    func getEpisodesWithFilters(name: String?) async throws -> RMEpisodesResponse
}

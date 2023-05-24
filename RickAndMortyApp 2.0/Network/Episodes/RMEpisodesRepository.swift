//
//  RMEpisodesRepository.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

import RxSwift

protocol RMEpisodesRepository {
    func getEpisodesByPage(page: Int) -> Single<RMEpisodesResponse>
    func getEpisodesByIds(ids: [Int]) -> Single<[RMEpisode]>
    func getEpisodeById(id: Int) -> Single<RMEpisode>
    func getEpisodesWithFilters(name: String?) -> Single<RMEpisodesResponse>
}

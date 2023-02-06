//
//  RMEpisodesRepository.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

import RxSwift

protocol RMEpisodesRepository {
    func getEpisodesByPage(page: Int) -> Observable<RMGetEpisodesResponse>
    func getEpisodesByIds(ids: [Int]) -> Observable<[RMEpisode]>
    func getEpisodeById(id: Int) -> Observable<RMEpisode>
    func getEpisodesWithFilters(name: String?) -> Observable<RMGetEpisodesResponse>
}

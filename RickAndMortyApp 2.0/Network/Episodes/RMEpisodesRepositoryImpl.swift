//
//  RMEpisodesRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

import RxSwift

struct RMEpisodesRepositoryImpl: RMEpisodesRepository {
    
    let dataSouce: RMEpisodesDataSource
    
    func getEpisodeById(id: Int) -> Single<RMEpisode> {
        return dataSouce.getEpisodeById(id: id)
    }
    
    func getEpisodesByPage(page: Int) -> Single<RMEpisodesResponse> {
        return dataSouce.getEpisodesByPage(page: page)
    }
    
    func getEpisodesByIds(ids: [Int]) -> Single<[RMEpisode]> {
        return dataSouce.getEpisodesByIds(ids: ids)
    }
    
    func getEpisodesWithFilters(name: String?) -> Single<RMEpisodesResponse> {
        return dataSouce.getEpisodesWithFilters(name: name)
    }
}

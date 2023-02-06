//
//  RMEpisodesRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

import RxSwift

struct RMEpisodesRepositoryImpl: RMEpisodesRepository {
    
    let dataSouce: RMEpisodesDataSource
    
    func getEpisodeById(id: Int) -> Observable<RMEpisode> {
        return dataSouce.getEpisodeById(id: id)
    }
    
    func getEpisodesByPage(page: Int) -> Observable<RMGetEpisodesResponse> {
        return dataSouce.getEpisodesByPage(page: page)
    }
    
    func getEpisodesByIds(ids: [Int]) -> Observable<[RMEpisode]> {
        return dataSouce.getEpisodesByIds(ids: ids)
    }
    
    func getEpisodesWithFilters(name: String?) -> Observable<RMGetEpisodesResponse> {
        return dataSouce.getEpisodesWithFilters(name: name)
    }
}

//
//  RMEpisodesDataSourceImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

import RxSwift
import Alamofire

struct RMEpisodesDataSourceImpl: RMEpisodesDataSource {

    func getEpisodeById(id: Int) -> Single<RMEpisode> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getEpisodesByIdsDataRequest(ids: [id]))
    }
    
    func getEpisodesByIds(ids: [Int]) -> Single<[RMEpisode]> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getEpisodesByIdsDataRequest(ids: ids))
    }
        
    func getEpisodesByPage(page: Int) -> Single<RMEpisodesResponse> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getEpisodesByPageDataRequest(page: page))
    }
    
    func getEpisodesWithFilters(name: String?) -> Single<RMEpisodesResponse> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getEpisodesWithFiltersDataRequest(name: name))
    }
}

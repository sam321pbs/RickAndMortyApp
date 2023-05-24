//
//  RMLocationDataSourceImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import RxSwift

struct RMLocationDataSourceImpl: RMLocationDataSource {
    
    func getLocationsByPage(page: Int) -> Single<RMLocationsResponse> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getLocationsByPageDataRequest(page: page))
    }
    
    func getLocationsByIds(ids: [Int]) -> Single<[RMLocation]> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getLocationsByIdsDataRequest(ids: ids))
    }
    
    func getLocationById(id: Int) -> Single<RMLocation> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getLocationsByIdsDataRequest(ids: [id]))
    }
    
    func getLocationsWithFilters(name: String?, type: String?) -> Single<RMLocationsResponse> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getLocationsWithFiltersDataRequest(name: name, type: type))
    }
}

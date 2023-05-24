//
//  RMLocationRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import RxSwift

struct RMLocationRepositoryImpl: RMLocationRepository {

    let dataSouce: RMLocationDataSource
    
    func getLocationsByPage(page: Int) -> Single<RMLocationsResponse> {
        return dataSouce.getLocationsByPage(page: page)
    }
    
    func getLocationsByIds(ids: [Int]) -> Single<[RMLocation]> {
        return dataSouce.getLocationsByIds(ids: ids)
    }
    
    func getLocationById(id: Int) -> Single<RMLocation> {
        return dataSouce.getLocationById(id: id)
    }
    
    func getLocationsWithFilters(name: String?, type: String?) -> Single<RMLocationsResponse> {
        return dataSouce.getLocationsWithFilters(name: name, type: type)
    }
}

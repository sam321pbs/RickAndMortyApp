//
//  RMLocationRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import RxSwift

struct RMLocationRepositoryImpl: RMLocationRepository {

    private let dataSouce: RMLocationDataSource
    
    init(dataSouce: RMLocationDataSource) {
        self.dataSouce = dataSouce
    }
    
    func getLocationsByPage(page: Int) -> Observable<RMLocationsResponse> {
        return dataSouce.getLocationsByPage(page: page)
    }
    
    func getLocationsByIds(ids: [Int]) -> Observable<[RMLocation]> {
        return dataSouce.getLocationsByIds(ids: ids)
    }
    
    func getLocationById(id: Int) -> Observable<RMLocation> {
        return dataSouce.getLocationById(id: id)
    }
    
    func getLocationsWithFilters(name: String?, type: String?) -> Observable<RMLocationsResponse> {
        return dataSouce.getLocationsWithFilters(name: name, type: type)
    }
}

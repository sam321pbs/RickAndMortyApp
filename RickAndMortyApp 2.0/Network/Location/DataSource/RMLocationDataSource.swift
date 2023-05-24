//
//  RMLocationDataSource.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import RxSwift

protocol RMLocationDataSource {
    func getLocationsByPage(page: Int) -> Single<RMLocationsResponse>
    func getLocationsByIds(ids: [Int]) -> Single<[RMLocation]>
    func getLocationById(id: Int) -> Single<RMLocation>
    func getLocationsWithFilters(
        name: String?,
        type: String?
    ) -> Single<RMLocationsResponse>
}

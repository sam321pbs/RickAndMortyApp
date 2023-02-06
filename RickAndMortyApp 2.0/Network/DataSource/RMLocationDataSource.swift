//
//  RMLocationDataSource.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import RxSwift

protocol RMLocationDataSource {
    func getLocationsByPage(page: Int) -> Observable<RMGetLocationsResponse>
    func getLocationsByIds(ids: [Int]) -> Observable<[RMLocation]>
    func getLocationById(id: Int) -> Observable<RMLocation>
    func getLocationsWithFilters(
        name: String?,
        type: String?
    ) -> Observable<RMGetLocationsResponse>
}

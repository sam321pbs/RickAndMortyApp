//
//  RMLocationDataSource.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

protocol RMLocationRemoteDataSource {
    func getLocationsByPage(page: Int) async throws -> RMLocationsResponse
    func getLocationsByIds(ids: [Int]) async throws -> [RMLocation]
    func getLocationById(id: Int) async throws -> RMLocation
    func getLocationsWithFilters(
        name: String?,
        type: String?
    ) async throws -> RMLocationsResponse
}

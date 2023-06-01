//
//  RMLocationRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

struct RMLocationRepositoryImpl: RMLocationRepository {

    @Injected(\.locationsRemoteDataSource) private var dataSource: RMLocationRemoteDataSource
    
    func getLocationsByPage(page: Int) async throws -> RMLocationsResponse {
        return try await dataSource.getLocationsByPage(page: page)
    }
    
    func getLocationsByIds(ids: [Int]) async throws -> [RMLocation] {
        return try await dataSource.getLocationsByIds(ids: ids)
    }
    
    func getLocationById(id: Int) async throws -> RMLocation {
        return try await dataSource.getLocationById(id: id)
    }
    
    func getLocationsWithFilters(name: String?, type: String?) async throws -> RMLocationsResponse {
        return try await dataSource.getLocationsWithFilters(name: name, type: type)
    }
}

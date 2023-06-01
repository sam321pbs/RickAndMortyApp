//
//  RMLocationRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

struct RMLocationRepositoryImpl: RMLocationRepository {

    let dataSouce: RMLocationDataSource
    
    func getLocationsByPage(page: Int) async throws -> RMLocationsResponse {
        return try await dataSouce.getLocationsByPage(page: page)
    }
    
    func getLocationsByIds(ids: [Int]) async throws -> [RMLocation] {
        return try await dataSouce.getLocationsByIds(ids: ids)
    }
    
    func getLocationById(id: Int) async throws -> RMLocation {
        return try await dataSouce.getLocationById(id: id)
    }
    
    func getLocationsWithFilters(name: String?, type: String?) async throws -> RMLocationsResponse {
        return try await dataSouce.getLocationsWithFilters(name: name, type: type)
    }
}

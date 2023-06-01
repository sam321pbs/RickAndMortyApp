//
//  RMLocationDataSourceImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

final class RMLocationRemoteDataSourceImpl: RMLocationRemoteDataSource {
    
    func getLocationsByPage(page: Int) async throws -> RMLocationsResponse {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getLocationsByPageDataRequest(page: page))
    }
    
    func getLocationsByIds(ids: [Int]) async throws -> [RMLocation] {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getLocationsByIdsDataRequest(ids: ids))
    }
    
    func getLocationById(id: Int) async throws -> RMLocation {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getLocationsByIdsDataRequest(ids: [id]))
    }
    
    func getLocationsWithFilters(name: String?, type: String?) async throws -> RMLocationsResponse {
        return try await DataSourceHelper.makeSingleRequest(RMApi.getLocationsWithFiltersDataRequest(name: name, type: type))
    }
}

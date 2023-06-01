//
//  LocationsDIValues.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 6/1/23.
//

private struct LocationsRemoteDataSouceKey: InjectionKey {
    static var currentValue: RMLocationRemoteDataSource = RMLocationRemoteDataSourceImpl()
}

private struct LocationsRepoKey: InjectionKey {
    static var currentValue: RMLocationRepository = RMLocationRepositoryImpl()
}

extension InjectedValues {
    var locationsRemoteDataSource: RMLocationRemoteDataSource {
        get { Self[LocationsRemoteDataSouceKey.self] }
        set { Self[LocationsRemoteDataSouceKey.self] = newValue }
    }
    
    var locationsRepo: RMLocationRepository {
        get { Self[LocationsRepoKey.self] }
        set { Self[LocationsRepoKey.self] = newValue }
    }
}

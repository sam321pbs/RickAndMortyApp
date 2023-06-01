//
//  EpisodesDIValues.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 6/1/23.
//

private struct EpisodesRemoteDataSouceKey: InjectionKey {
    static var currentValue: RMEpisodesRemoteDataSource = RMEpisodesRemoteDataSourceImpl()
}

private struct EpisodesRepoKey: InjectionKey {
    static var currentValue: RMEpisodesRepository = RMEpisodesRepositoryImpl()
}

extension InjectedValues {
    var episodesRemoteDataSource: RMEpisodesRemoteDataSource {
        get { Self[EpisodesRemoteDataSouceKey.self] }
        set { Self[EpisodesRemoteDataSouceKey.self] = newValue }
    }
    
    var episodesRepo: RMEpisodesRepository {
        get { Self[EpisodesRepoKey.self] }
        set { Self[EpisodesRepoKey.self] = newValue }
    }
}

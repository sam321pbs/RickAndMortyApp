//
//  CharactersDIValues.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 6/1/23.
//

private struct CharactersRemoteDataSouceKey: InjectionKey {
    static var currentValue: RMCharactersDataSource = RMCharactersDataSourceImpl()
}

private struct CharactersRepoKey: InjectionKey {
    static var currentValue: RMCharactersRepository = RMCharactersRepositoryImpl()
}

extension InjectedValues {
    var charactersRemoteDataSource: RMCharactersDataSource {
        get { Self[CharactersRemoteDataSouceKey.self] }
        set { Self[CharactersRemoteDataSouceKey.self] = newValue }
    }
    
    var charactersRepo: RMCharactersRepository {
        get { Self[CharactersRepoKey.self] }
        set { Self[CharactersRepoKey.self] = newValue }
    }
}

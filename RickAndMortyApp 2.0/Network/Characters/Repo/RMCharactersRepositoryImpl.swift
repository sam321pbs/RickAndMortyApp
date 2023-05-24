//
//  RMCharactersRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import Foundation
import RxSwift

struct RMCharactersRepositoryImpl: RMCharactersRepository {
    
    let dataSouce: RMCharactersDataSource
    
    func getCharactersByPage(page: Int) -> Single<RMCharactersResponse> {
        return dataSouce.getCharactersByPage(page: page)
    }
    
    func getCharactersByIds(ids: [Int]) -> Single<[RMCharacter]> {
        return dataSouce.getCharactersByIds(ids: ids)
    }
    
    func getCharactersById(id: Int) -> Single<RMCharacter> {
        return dataSouce.getCharacterById(id: id)
    }
    
    func getCharactersWithFilters(name: String?, status: RMCharacterStatus?, gender: RMCharacterGender?) -> Single<RMCharactersResponse> {
        return dataSouce.getCharactersWithFilters(name: name, status: status, gender: gender)
    }
}

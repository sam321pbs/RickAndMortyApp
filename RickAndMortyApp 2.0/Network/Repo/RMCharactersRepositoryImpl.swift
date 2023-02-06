//
//  RMCharactersRepositoryImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import Foundation
import RxSwift

struct RMCharactersRepositoryImpl: RMCharactersRepository {
    
    var dataSouce: RMCharactersDataSource!
    
    init(dataSouce: RMCharactersDataSource) {
        self.dataSouce = dataSouce
    }
    
    func getCharactersByPage(page: Int) -> Observable<RMGetCharactersResponse> {
        return dataSouce.getCharactersByPage(page: page)
    }
    
    func getCharactersByIds(ids: [Int]) -> Observable<[RMCharacter]> {
        return dataSouce.getCharactersByIds(ids: ids)
    }
    
    func getCharactersById(id: Int) -> Observable<RMCharacter> {
        return dataSouce.getCharacterById(id: id)
    }
    
    func getCharactersWithFilters(name: String?, status: RMCharacterStatus?, gender: RMCharacterGender?) -> Observable<RMGetCharactersResponse> {
        return dataSouce.getCharactersWithFilters(name: name, status: status, gender: gender)
    }
}

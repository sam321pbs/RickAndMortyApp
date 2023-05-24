//
//  RMGetAllCharactersDataSourceImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import Foundation
import RxSwift
import Alamofire

struct RMCharactersDataSourceImpl: RMCharactersDataSource {

    func getCharacterById(id: Int) -> Single<RMCharacter> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getCharactersByIdsDataRequest(ids: [id]))
    }
    
    func getCharactersByIds(ids: [Int]) -> Single<[RMCharacter]> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getCharactersByIdsDataRequest(ids: ids))
    }
    
    func getCharactersByPage(page: Int) -> Single<RMCharactersResponse> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getCharactersByPageDataRequest(page: page))
    }
    
    func getCharactersWithFilters(
        name: String?,
        status: RMCharacterStatus?,
        gender: RMCharacterGender?
    ) -> Single<RMCharactersResponse> {
        return DataSourceHelper.makeSingleAlamoRequest(RMApi.getCharactersWithFiltersDataRequest(name: name, status: status, gender: gender))
    }
}

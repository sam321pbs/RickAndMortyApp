//
//  GetAllCharactersDataSource.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import Foundation
import RxSwift

protocol RMCharactersDataSource {
    func getCharactersByPage(page: Int) -> Single<RMCharactersResponse>
    func getCharactersByIds(ids: [Int]) -> Single<[RMCharacter]>
    func getCharacterById(id: Int) -> Single<RMCharacter>
    func getCharactersWithFilters(
        name: String?,
        status: RMCharacterStatus?,
        gender: RMCharacterGender?
    ) -> Single<RMCharactersResponse>
}

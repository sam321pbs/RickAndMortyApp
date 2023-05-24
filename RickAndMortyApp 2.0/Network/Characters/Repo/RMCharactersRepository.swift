//
//  CharactersRepositories.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import Foundation
import RxSwift

protocol RMCharactersRepository {
    func getCharactersByPage(page: Int) -> Single<RMCharactersResponse>
    func getCharactersByIds(ids: [Int]) -> Single<[RMCharacter]>
    func getCharactersById(id: Int) -> Single<RMCharacter>
    func getCharactersWithFilters(
        name: String?,
        status: RMCharacterStatus?,
        gender: RMCharacterGender?
    ) -> Single<RMCharactersResponse>
}

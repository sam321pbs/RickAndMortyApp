//
//  CharactersRepositories.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import Foundation
import RxSwift

protocol RMCharactersRepository {
    func getCharactersByPage(page: Int) -> Observable<RMGetCharactersResponse>
    func getCharactersByIds(ids: [Int]) -> Observable<[RMCharacter]>
    func getCharactersById(id: Int) -> Observable<RMCharacter>
    func getCharactersWithFilters(
        name: String?,
        status: RMCharacterStatus?,
        gender: RMCharacterGender?
    ) -> Observable<RMGetCharactersResponse>
}

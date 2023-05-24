//
//  RMCharactersViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/24/23.
//

import Foundation
import RxSwift
import RxCocoa

final class RMCharactersViewModel {
    
    private let repo: RMCharactersRepository
    
    private let disposeBag = DisposeBag()
    
    private var nextPage: Int?
    
    var state: BehaviorRelay<RMViewState> = BehaviorRelay(value: .initial)
    
    var isLoadingAdditionalCharacters = false
    
    var characters: [RMCharacter] = []

    // MARK: - Init
    
    init(
        repo: RMCharactersRepository
    ) {
        self.repo = repo
    }
    
    // MARK: - Public
    
    func fetchCharacters() {
        state.accept(.loading)
        
        repo.getCharactersByPage(page: 1).subscribe(
            onSuccess: {[weak self] response in
                guard let me = self else { return }
                me.handleSuccessResponse(response: response)
            },
            onFailure: {[weak self] error in
                guard let me = self else { return }
                print("Error getting characters")
                me.state.accept(.error(error))
            }
        ).disposed(by: disposeBag)
    }
    
    func fetchAddtionalCharacters() {
        if isLoadingAdditionalCharacters || nextPage == -1 || nextPage == nil {
            return
        }
        
        isLoadingAdditionalCharacters = true
        repo.getCharactersByPage(page: self.nextPage ?? 1).subscribe(
            onSuccess: {[weak self] response in
                guard let me = self else { return }

                me.handleSuccessResponse(response: response)
                me.isLoadingAdditionalCharacters = false
            },
            onFailure: {[weak self] error in
                guard let me = self else { return }
                self?.isLoadingAdditionalCharacters = false
                me.state.accept(.error(error))
            }
        ).disposed(by: disposeBag)
    }
    
    // MARK: - Private
    
    private func handleSuccessResponse(response: RMCharactersResponse) {
        if let nextPage = response.info.next {
            self.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "-1")
        } else {
            self.nextPage = nil
        }
        characters.append(contentsOf: response.results)
        state.accept(.success)
    }
}

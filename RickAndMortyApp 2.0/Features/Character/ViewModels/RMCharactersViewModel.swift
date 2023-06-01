//
//  RMCharactersViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/24/23.
//

import Foundation
import Combine

@MainActor
final class RMCharactersViewModel: ObservableObject {
    
    private let repo: RMCharactersRepository
    
    private var nextPage: Int?
    
    @Published var viewState: RMViewState = .initial
    
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
        viewState = .loading
        
        Task.init {
            do {
                let charactersResponse = try await repo.getCharactersByPage(page: 1)
                handleSuccessResponse(response: charactersResponse)
            } catch let error {
                print("Error getting characters")
                viewState = .error(error)
            }
        }
    }
    
    func fetchAddtionalCharacters() {
        if isLoadingAdditionalCharacters || nextPage == -1 || nextPage == nil {
            return
        }
        
        isLoadingAdditionalCharacters = true
        
        Task.init {
            do {
                let charactersResponse = try await repo.getCharactersByPage(page: self.nextPage ?? 1)
                handleSuccessResponse(response: charactersResponse)
                isLoadingAdditionalCharacters = false
            } catch let error {
                print("Error getting characters")
                isLoadingAdditionalCharacters = false
                viewState = .error(error)
            }
        }
    }
    
    // MARK: - Private
    
    private func handleSuccessResponse(response: RMCharactersResponse) {
        if let nextPage = response.info.next {
            self.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "-1")
        } else {
            self.nextPage = nil
        }
        characters.append(contentsOf: response.results)
        viewState = .success
    }
}

//
//  RMSearchViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/1/23.
//

// Responsibilites
// - show search results
// - show no results
// - kick off api request

import Combine

@MainActor
final class RMSearchViewModel: ObservableObject {
    
    @Injected(\.charactersRepo) private var charactersRepo: RMCharactersRepository
    
    @Injected(\.episodesRepo) private var episodesRepo: RMEpisodesRepository
    
    @Injected(\.locationsRepo) private var locationsRepo: RMLocationRepository
    
    private var nextPage: Int?
    
    @Published var viewState: RMViewState = .initial
    
    var isLoadingAdditionalCharacters = false
    
    let config: RMSearchViewController.Config
    
    var characters: [RMCharacter] = []
    
    var episodes: [RMEpisode] = []
    
    var locations: [RMLocation] = []
    
    var count: Int {
        switch config.type {
        case .character:
            return characters.count
        case .episode:
            return episodes.count
        case .location:
            return locations.count
        }
    }

    // MARK: - Init
    
    init(
        config: RMSearchViewController.Config
    ) {
        self.config = config
    }
    
    // MARK: - Public
    
    func startSearch(
        searchText: String?,
        status: RMCharacterStatus? = nil,
        gender: RMCharacterGender? = nil,
        locationType: String? = nil
    ) {
        characters = []
        episodes = []
        locations = []
        
        if let searchText = searchText {
            switch config.type {
            case .character:
                fetchCharacters(name: searchText, status: status, gender: gender)
            case .episode:
                fetchEpisodes(by: searchText)
            case.location:
                fetchLocations(by: searchText, type: locationType)
            }
        }
    }
    
    // MARK: - Characters
    
    func fetchCharacters(name: String?, status: RMCharacterStatus?, gender: RMCharacterGender?) {
        viewState = .loading
        
        Task.init {
            do {
                let characterResponse = try await charactersRepo.getCharactersWithFilters(name: name, status: status, gender: gender)
                handleCharacterSuccessResponse(response: characterResponse)
            } catch let error {
                viewState = .error(error)
            }
        }
    }
    
    func fetchAddtionalCharacters(name: String?, status: RMCharacterStatus?, gender: RMCharacterGender?) {
        if isLoadingAdditionalCharacters || nextPage == -1 {
            return
        }
        isLoadingAdditionalCharacters = true
        
        Task.init {
            do {
                let characterResponse = try await charactersRepo.getCharactersWithFilters(name: name, status: status, gender: gender)
                handleCharacterSuccessResponse(response: characterResponse)
                isLoadingAdditionalCharacters = false
            } catch let error {
                viewState = .error(error)
                isLoadingAdditionalCharacters = false
            }
        }
    }
    
    private func handleCharacterSuccessResponse(response: RMCharactersResponse) {
        if let nextPage = response.info.next {
            self.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "-1")
        }
        characters.append(contentsOf: response.results)
        viewState = .success
    }
    
    // MARK: - Episodes
    
    func fetchEpisodes(by name: String) {
        viewState = .loading
        
        Task.init {
            do {
                let episodesResponse = try await self.episodesRepo.getEpisodesWithFilters(name: name)
                if let nextPage = episodesResponse.info.next {
                    self.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "-1")
                }
                episodes = episodesResponse.results
                viewState = .success
            } catch let error {
                viewState = .error(error)
            }
        }
    }
    
    func fetchAddtionalEpisodes(name: String) {
        if isLoadingAdditionalCharacters || nextPage == -1 {
            return
        }
        isLoadingAdditionalCharacters = true
        
        Task.init {
            do {
                let episodesResponse = try await self.episodesRepo.getEpisodesWithFilters(name: name)
                if let nextPage = episodesResponse.info.next {
                    self.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "-1")
                }
                episodes.append(contentsOf: episodesResponse.results)
                viewState = .success
                isLoadingAdditionalCharacters = false
            } catch let error {
                viewState = .error(error)
                isLoadingAdditionalCharacters = false
            }
        }
    }
    
    // MARK: - Location
    
    func fetchLocations(by name: String?, type: String?) {
        viewState = .loading
        
        Task.init {
            do {
                let locationResponse = try await self.locationsRepo.getLocationsWithFilters(name: name, type: type)
                locations.append(contentsOf: locationResponse.results)
                viewState = .success
            } catch let error {
                viewState = .error(error)
            }
        }
    }
}

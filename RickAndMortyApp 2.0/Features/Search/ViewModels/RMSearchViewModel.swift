//
//  RMSearchViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/1/23.
//

import RxSwift
import RxCocoa

// Responsibilites
// - show search results
// - show no results
// - kick off api request

final class RMSearchViewModel {
    
    private let characterRepo: RMCharactersRepository
    
    private let episodesRepo: RMEpisodesRepository
    
    private let locationsRepo: RMLocationRepository
    
    private let disposeBag = DisposeBag()
    
    private var nextPage: Int?
    
    var state: BehaviorRelay<RMViewState> = BehaviorRelay(value: .initial)
    
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
        config: RMSearchViewController.Config,
        characterRepo: RMCharactersRepository,
        episodesRepo: RMEpisodesRepository,
        locationsRepo: RMLocationRepository
    ) {
        self.config = config
            self.characterRepo = characterRepo
        self.episodesRepo = episodesRepo
        self.locationsRepo = locationsRepo
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
        state.accept(.loading)
        characterRepo.getCharactersWithFilters(name: name, status: status, gender: gender).subscribe(
            onNext: {[weak self] response in
                guard let me = self else { return }
                me.handleCharacterSuccessResponse(response: response)
            }, onError: {[weak self] error in
                guard let me = self else { return }
                me.state.accept(.error(error))
            }
        ).disposed(by: disposeBag)
    }
    
    func fetchAddtionalCharacters(name: String?, status: RMCharacterStatus?, gender: RMCharacterGender?) {
        if isLoadingAdditionalCharacters || nextPage == -1 {
            return
        }
        isLoadingAdditionalCharacters = true
        characterRepo.getCharactersWithFilters(name: name, status: status, gender: gender).subscribe(
            onNext: {[weak self] response in
                guard let me = self else { return }
                me.handleCharacterSuccessResponse(response: response)
                me.isLoadingAdditionalCharacters = false
            }, onError: {[weak self] error in
                guard let me = self else { return }
                me.state.accept(.error(error))
                me.isLoadingAdditionalCharacters = false
            }
        ).disposed(by: disposeBag)
    }
    
    private func handleCharacterSuccessResponse(response: RMCharactersResponse) {
        if let nextPage = response.info.next {
            self.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "-1")
        }
        characters.append(contentsOf: response.results)
        state.accept(.success)
    }
    
    // MARK: - Episodes
    
    func fetchEpisodes(by name: String) {
        state.accept(.loading)
        episodesRepo.getEpisodesWithFilters(name: name).subscribe(
            onNext: {[weak self] episodesResponse in
                guard let me = self else { return }
                if let nextPage = episodesResponse.info.next {
                    me.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "-1")
                }
                me.episodes = episodesResponse.results
                me.state.accept(.success)
            }, onError: {[weak self] error in
                guard let me = self else { return }
                me.state.accept(.error(error))
            }
        ).disposed(by: disposeBag)
    }
    
    func fetchAddtionalEpisodes(name: String) {
        if isLoadingAdditionalCharacters || nextPage == -1 {
            return
        }
        isLoadingAdditionalCharacters = true
        episodesRepo.getEpisodesWithFilters(name: name).subscribe(
            onNext: {[weak self] episodesResponse in
                guard let me = self else { return }
                if let nextPage = episodesResponse.info.next {
                    me.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "-1")
                }
                me.episodes.append(contentsOf: episodesResponse.results)
                me.state.accept(.success)
                me.isLoadingAdditionalCharacters = false
            }, onError: {[weak self] error in
                guard let me = self else { return }
                me.state.accept(.error(error))
                me.isLoadingAdditionalCharacters = false
            }
        ).disposed(by: disposeBag)
    }
    
    // MARK: - Location
    
    func fetchLocations(by name: String?, type: String?) {
        state.accept(.loading)
        locationsRepo.getLocationsWithFilters(name: name, type: type).subscribe(
            onNext: { [weak self] response in
                guard let me = self else { return }
                me.locations.append(contentsOf: response.results)
                me.state.accept(.success)
            },
            onError: { [weak self] error in
                guard let me = self else { return }
                me.state.accept(.error(error))
            }
        ).disposed(by: disposeBag)
    }
}

//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/25/23.
//

import Combine

final class RMCharacterDetailViewViewModel: ObservableObject {
    
    @Published var viewState: RMViewState = .initial
    
    @Injected(\.episodesRepo) private var episodesRepo: RMEpisodesRepository
    
    public var sections: [SectionType] = []
    
    let character: RMCharacter
    
    // MARK: - Init
    
    init(
        character: RMCharacter
    ) {
        self.character = character
        setupSections()
    }
    
    // MARK: - Private
    
    private func setupSections() {
        sections = [
            .photo(imageUrl: character.image),
            .information(
                characterInfo:
                    [
                        .init(text: character.status.rawValue, type: .status),
                        .init(text: character.species, type: .species),
                        .init(text: character.type, type: .type),
                        .init(text: character.gender.rawValue, type: .gender),
                        .init(text: character.origin.name, type: .origin),
                        .init(text: character.location.name, type: .location),
                        .init(text: DateUtils.convertToReadableShortDate(from: character.created), type: .created),
                        .init(text: String(describing: character.episode.count), type: .episodeCount)
                    ]
            )
        ]
        fetchEpisodes()
    }
    
    private func fetchEpisodes() {
        let episodes: [Int] = character.episode.map {
            if let number = $0.getLastNumberInUrl() {
                return number
            }
            
            return -1
        }.filter { number in number >= 0 }
        
        Task.init {
            do {
                var episodesUIModels: [RMCharacterDetailsEpisodeUIModel]?
                if episodes.count == 1 {
                    let episodeResponse = try await episodesRepo.getEpisodeById(id: episodes[0])
                    episodesUIModels = [episodeResponse.convertToUIModel()]
                } else {
                    let episodeResponse = try await episodesRepo.getEpisodesByIds(ids: episodes)
                    episodesUIModels = episodeResponse.map { $0.convertToUIModel() }
                }
                sections.append(SectionType.episodes(episodes: episodesUIModels!))
                await MainActor.run {
                    viewState = .success
                }
                
            } catch let error {
                print("Error getting episode")
                viewState = .error(error)
            }
        }
    }
}

extension RMCharacterDetailViewViewModel {
    enum SectionType {
        case photo(imageUrl: String)
        case information(characterInfo: [RMCharacterDetailInformationUIModel])
        case episodes(episodes: [RMCharacterDetailsEpisodeUIModel])
    }
}

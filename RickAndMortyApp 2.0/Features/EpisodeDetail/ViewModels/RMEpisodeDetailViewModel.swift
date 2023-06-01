//
//  EpisodeDetailViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/30/23.
//

import Combine

@MainActor
final class RMEpisodeDetailViewModel: ObservableObject {
    
    @Injected(\.episodesRepo) private var episodesRepo: RMEpisodesRepository
    
    @Injected(\.charactersRepo) private var charactersRepo: RMCharactersRepository
    
    @Published var viewState: RMViewState = .initial
    
    public private(set) var sections: [RMEpisodeDetailViewModel.SectionType] = []
    
    enum SectionType {
        case information(episode: [RMEpisodeInformationUIModel])
        case characters(characters: [RMCharacter])
    }
    
    // MARK: Public
    
    func fetchEpisodeDetails(episodeId: Int) {
        Task.init {
            do {
                let episode = try await episodesRepo.getEpisodeById(id: episodeId)
                
                let characterIds = getCharacterIds(episode: episode)
                
                self.sections = [
                    .information(episode: self.convertEpisodeToUIInfo(episode: episode))
                ]
                
                let characters = try await charactersRepo.getCharactersByIds(ids: characterIds)
                
                sections.append(.characters(characters: characters))
                viewState = .success
            } catch let error {
                print("Error getting episode details")
                viewState = .error(error)
            }
        }
    }
    
    // MARK: Private
    
    private func getCharacterIds(episode: RMEpisode) -> [Int] {
        let characterIds: [Int] = episode.characters.map {
            if let number = $0.getLastNumberInUrl() {
                return number
            }
            
            return -1
        }.filter { number in number >= 0 }
        
        return characterIds
    }
    
    private func convertEpisodeToUIInfo(episode: RMEpisode) -> [RMEpisodeInformationUIModel] {
        return [
            .init(title: "Episode Title", value: episode.name),
            .init(title: "Air Date", value: episode.air_date),
            .init(title: "Episode", value: episode.episode),
            .init(title: "Created", value: DateUtils.convertToReadableShortDate(from: episode.created))
        ]
    }
}

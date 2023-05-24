//
//  EpisodeDetailViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/30/23.
//

import RxSwift
import RxCocoa

class RMEpisodeDetailViewModel {
    
    private let episodesRepo: RMEpisodesRepository
    
    private let charactersRepo: RMCharactersRepository
    
    private let disposeBag = DisposeBag()
    
    var viewState: BehaviorRelay<RMViewState> = BehaviorRelay(value: .initial)
    
    public private(set) var sections: [RMEpisodeDetailViewModel.SectionType] = []
    
    enum SectionType {
        case information(episode: [RMEpisodeInformationUIModel])
        case characters(characters: [RMCharacter])
    }
    
    // MARK: Init
    
    init(
        episodesRepo: RMEpisodesRepository,
        charactersRepo: RMCharactersRepository
    ) {
        self.episodesRepo = episodesRepo
        self.charactersRepo = charactersRepo
    }
    
    // MARK: Public
    
    func fetchEpisodeDetails(episodeId: Int) {
        
        episodesRepo.getEpisodeById(id: episodeId).flatMap({ episode -> Single<[RMCharacter]> in
            let characterIds: [Int] = episode.characters.map {
                if let number = $0.getLastNumberInUrl() {
                    return number
                }
                
                return -1
            }.filter { number in number >= 0 }
            
            self.sections = [
                .information(episode: self.convertEpisodeToUIInfo(episode: episode))
            ]
            return self.charactersRepo.getCharactersByIds(ids: characterIds)
        }).subscribe(
            onSuccess: { [weak self] characters in
                guard let me = self else { return }
                me.sections.append(.characters(characters: characters))
                me.viewState.accept(.success)
            },
            onFailure: { [weak self] error in
                guard let me = self else { return }
                print("Error getting episode details")
                me.viewState.accept(.error(error))
            }).disposed(by: disposeBag)
        
    }
    
    // MARK: Private
    
    private func convertEpisodeToUIInfo(episode: RMEpisode) -> [RMEpisodeInformationUIModel] {
        return [
            .init(title: "Episode Title", value: episode.name),
            .init(title: "Air Date", value: episode.air_date),
            .init(title: "Episode", value: episode.episode),
            .init(title: "Created", value: DateUtils.convertToReadableShortDate(from: episode.created))
        ]
    }
}

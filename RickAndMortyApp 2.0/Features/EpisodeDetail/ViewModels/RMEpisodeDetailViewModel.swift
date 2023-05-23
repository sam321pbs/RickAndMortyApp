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
        episodesRepo.getEpisodeById(id: episodeId).flatMap { episode ->
            Observable<[RMEpisodeDetailViewModel.SectionType]> in
            return self.episodeDetailUIModelObserver(episode: episode)
        }.subscribe(onNext: { [weak self] sections in
            guard let me = self else { return }
            me.sections = sections
            me.viewState.accept(.success)
        }, onError: { [weak self] error in
            guard let me = self else { return }
            print("Error getting episode details")
            me.viewState.accept(.error(error))
        }
        ).disposed(by: disposeBag)
    }
    
    // MARK: Private
    
    private func episodeDetailUIModelObserver(episode: RMEpisode) -> Observable<[RMEpisodeDetailViewModel.SectionType]> {
        let characterIds: [Int] = episode.characters.map {
            if let number = $0.getLastNumberInUrl() {
                return number
            }
            
            return -1
        }.filter { number in number >= 0 }
        
        let charactersObservable = self.charactersRepo.getCharactersByIds(ids: characterIds)
        
        return charactersObservable.flatMap({ characters -> Observable<[RMEpisodeDetailViewModel.SectionType]> in
            return Observable<[RMEpisodeDetailViewModel.SectionType]>.create { (observer) -> Disposable in
                let sections: [RMEpisodeDetailViewModel.SectionType] = [
                    .information(episode: self.convertEpisodeToUIInfo(episode: episode)),
                    .characters(characters: characters)
                ]
                observer.onNext(sections)
                return Disposables.create()
            }
        })
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

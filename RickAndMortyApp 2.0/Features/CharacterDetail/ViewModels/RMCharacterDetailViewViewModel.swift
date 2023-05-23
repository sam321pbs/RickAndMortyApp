//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/25/23.
//

import RxSwift
import RxCocoa

final class RMCharacterDetailViewViewModel {
    
    private let episodesRepo: RMEpisodesRepository
    
    public var sections: [SectionType] = []
    
    private let disposeBag = DisposeBag()
    
    var viewState: BehaviorRelay<RMViewState> = BehaviorRelay(value: .initial)
    
    let character: RMCharacter
    
    enum SectionType {
        case photo(imageUrl: String)
        case information(characterInfo: [RMCharacterDetailInformationUIModel])
        case episodes(episodes: [RMCharacterDetailsEpisodeUIModel])
    }
    
    // MARK: - Init
    
    init(
        character: RMCharacter,
        episodesRepo: RMEpisodesRepository
    ) {
        self.character = character
        self.episodesRepo = episodesRepo
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
        
        if episodes.count == 1 {
            episodesRepo.getEpisodeById(id: episodes[0]).subscribe(
                onNext: { [weak self] episode in
                    guard let me = self else { return }
                    me.sections.append(SectionType.episodes(episodes: [episode.convertToUIModel()]))
                    me.viewState.accept(.success)
                },
                onError: { [weak self] error in
                    guard let me = self else { return }
                    print("Error getting episode")
                    me.viewState.accept(.error(error))
                }
            ).disposed(by: disposeBag)
        } else {
            episodesRepo.getEpisodesByIds(ids: episodes).subscribe(
                onNext: { [weak self] episodes in
                    guard let me = self else { return }
                    let episodesUIModels = episodes.map { $0.convertToUIModel() }
                    me.sections.append(SectionType.episodes(episodes: episodesUIModels))
                    me.viewState.accept(.success)
                },
                onError: { [weak self] error in
                    guard let me = self else { return }
                    print("Error getting episodes")
                    me.viewState.accept(.error(error))
                }
            ).disposed(by: disposeBag)
        }
    }
}

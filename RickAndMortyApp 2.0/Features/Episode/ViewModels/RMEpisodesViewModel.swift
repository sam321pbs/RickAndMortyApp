//
//  RMEpisodesViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/27/23.
//

import RxSwift
import RxCocoa

final class RMEpisodesViewModel {
    
    private var episodesRepo: RMEpisodesRepository
    
    var isLoadingMore = false
    
    private let disposeBag = DisposeBag()
    
    private var nextPage: Int?
    
    var state: BehaviorRelay<RMViewState> = BehaviorRelay(value: .initial)
    
    var episodes: [RMCharacterDetailsEpisodeUIModel] = []
    
    // MARK: - Init
    
    init(episodesRepo: RMEpisodesRepository) {
        self.episodesRepo = episodesRepo
    }
    
    // MARK: - Public
    
    func fetchEpisodesFirstPage() {
        state.accept(.loading)
        episodesRepo.getEpisodesByPage(page: 1).subscribe(
            onNext: {[weak self] response in
                guard let me = self else { return }
                me.handleEpisodeResponse(response)
            }, onError: {[weak self] error in
                guard let me = self else { return }
                me.handleError(error)
            }
        ).disposed(by: disposeBag)
    }
    
    func fetchAdditionalEpisodes() {
        guard let nextPage = nextPage else {
            return
        }
         
        isLoadingMore = true
        episodesRepo.getEpisodesByPage(page: nextPage).subscribe(
            onNext: {[weak self] response in
                guard let me = self else { return }
                me.isLoadingMore = false
                me.handleEpisodeResponse(response)
                
            }, onError: {[weak self] error in
                guard let me = self else { return }
                me.handleError(error)
            }
        ).disposed(by: disposeBag)
    }
    
    // MARK: - private
    
    private func handleEpisodeResponse(_ response: RMEpisodesResponse) {
        if let nextPage = response.info.next {
            self.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "error")
        } else {
            self.nextPage = nil
        }
        episodes.append(contentsOf: response.results.map{
            $0.convertToUIModel()
        })
        state.accept(.success)
    }
    
    private func handleError(_ error: Error) {
        print("Error getting episodes")
        isLoadingMore = false
        state.accept(.error(error))
    }
}

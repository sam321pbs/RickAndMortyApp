//
//  RMLocationViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import RxSwift
import RxCocoa

final class RMLocationViewModel {
    
    var state: BehaviorRelay<RMViewState> = BehaviorRelay(value: .initial)
    
    public private(set) var isLoadingMore = false
    
    public private(set) var locations: [RMLocation] = []
    
    private var nextPage: Int?
    
    private let repo: RMLocationRepository
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(repo: RMLocationRepository) {
        self.repo = repo
    }
    
    // MARK: - Public
    
    func fetchLocations() {
        isLoadingMore = true
        fetch(page: 1)
    }
    
    func fetchAdditionalLocations() {
        guard let nextPage = nextPage else {
            return
        }
        self.isLoadingMore = true
        fetch(page: nextPage)
    }
    
    // MARK: - Private
    
    private func fetch(page: Int) {
        repo.getLocationsByPage(page: page).subscribe(
            onNext: {[weak self] response in
                guard let me = self else { return }
                me.handleEpisodeResponse(response)
            }, onError: {[weak self] error in
                guard let me = self else { return }
                me.handleError(error)
            }, onCompleted: {}
        ).disposed(by: disposeBag)
    }
    
    private func handleEpisodeResponse(_ response: RMGetLocationsResponse) {
        if let nextPage = response.info.next {
            self.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "error")
        } else {
            self.nextPage = nil
        }
        locations.append(contentsOf: response.results)
        self.isLoadingMore = false
        state.accept(.success)
    }
    
    private func handleError(_ error: Error) {
        print("Error getting episodes")
        self.isLoadingMore = false
        state.accept(.error(error))
    }
}

//
//  RMLocationViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import Combine

@MainActor
final class RMLocationViewModel: ObservableObject {
    
    @Published var viewState: RMViewState = .initial
    
    public private(set) var isLoadingMore = false
    
    public private(set) var locations: [RMLocation] = []
    
    private var nextPage: Int?
    
    private let repo: RMLocationRepository
    
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
        Task.init {
            do {
                let locationResponse = try await repo.getLocationsByPage(page: page)
                handleEpisodeResponse(locationResponse)
            } catch let error {
                handleError(error)
            }
        }
    }
    
    private func handleEpisodeResponse(_ response: RMLocationsResponse) {
        if let nextPage = response.info.next {
            self.nextPage = Int(nextPage.getQueryStringParameter(param: "page") ?? "error")
        } else {
            self.nextPage = nil
        }
        locations.append(contentsOf: response.results)
        self.isLoadingMore = false
        viewState = .success
    }
    
    private func handleError(_ error: Error) {
        print("Error getting episodes")
        self.isLoadingMore = false
        viewState = .error(error)
    }
}

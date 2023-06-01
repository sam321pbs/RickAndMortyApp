//
//  RMEpisodesViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/27/23.
//

import Combine

@MainActor
final class RMEpisodesViewModel: ObservableObject {
    
    @Published var viewState: RMViewState = .initial
    
    @Injected(\.episodesRepo) private var episodesRepo: RMEpisodesRepository
    
    var isLoadingMore = false
    
    private var nextPage: Int?
    
    var episodes: [RMCharacterDetailsEpisodeUIModel] = []
    
    // MARK: - Public
    
    func fetchEpisodesFirstPage() {
        viewState = .loading
        
        Task.init {
            do {
                let episodesResponse = try await episodesRepo.getEpisodesByPage(page: 1)
                handleEpisodeResponse(episodesResponse)
            } catch let error {
                handleError(error)
            }
        }
    }
    
    func fetchAdditionalEpisodes() {
        guard let nextPage = nextPage else {
            return
        }
         
        isLoadingMore = true
        
        Task.init {
            do {
                let episodesResponse = try await episodesRepo.getEpisodesByPage(page: nextPage)
                isLoadingMore = false
                handleEpisodeResponse(episodesResponse)
            } catch let error {
                handleError(error)
            }
        }
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
        viewState = .success
    }
    
    private func handleError(_ error: Error) {
        print("Error getting episodes")
        isLoadingMore = false
        viewState = .error(error)
    }
}

//
//  RMEpisodesViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/27/23.
//

import Combine

final class RMEpisodesViewModel: ObservableObject {
    
    @Published var viewState: RMViewState = .initial
    
    @Injected(\.episodesRepo) var episodesRepo: RMEpisodesRepository
    
    var isLoadingMore = false
    
    private var nextPage: Int?
    
    var episodes: [RMCharacterDetailsEpisodeUIModel] = []
    
    init() {}
    
    // MARK: - Public
    
    func fetchEpisodesFirstPage() async {
        viewState = .loading
        
        do {
            let episodesResponse = try await episodesRepo.getEpisodesByPage(page: 1)
            await MainActor.run {
                handleEpisodeResponse(episodesResponse)
            }
        } catch let error {
            await MainActor.run {
                handleError(error)
            }
        }
    }
    
    func fetchAdditionalEpisodes() async {
        guard let nextPage = nextPage else {
            return
        }
         
        isLoadingMore = true
        
        do {
            let episodesResponse = try await episodesRepo.getEpisodesByPage(page: nextPage)
            isLoadingMore = false
            await MainActor.run {
                handleEpisodeResponse(episodesResponse)
            }
        } catch let error {
            await MainActor.run {
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

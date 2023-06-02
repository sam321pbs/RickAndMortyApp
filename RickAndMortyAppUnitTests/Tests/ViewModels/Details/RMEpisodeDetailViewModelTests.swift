//
//  RMEpisodeDetailViewModelTests.swift
//  RickAndMortyAppUnitTests
//
//  Created by Samuel Mengistu on 6/2/23.
//

import XCTest

final class RMEpisodeDetailViewModelTests: XCTestCase {
    
    private var viewModel: RMEpisodeDetailViewModel!

    override func setUpWithError() throws {
        viewModel = .init()
        viewModel.episodesRepo = MockedRMEpisodesRepository()
        viewModel.charactersRepo = MockedRMCharactersRepository()
    }

    func test_fetchEpisodeDetails_gets_success_viewState() async {
        
        await viewModel.fetchEpisodeDetails(episodeId: 1)
        
        XCTAssertEqual(viewModel.viewState, RMViewState.success)
    }
    
    func test_fetchEpisodeDetails_has_sections() async {
        
        await viewModel.fetchEpisodeDetails(episodeId: 1)
        
        XCTAssertEqual(viewModel.sections.count, 2)
    }
}

//
//  RMEpisodesViewModelTests.swift
//  RickAndMortyAppUnitTests
//
//  Created by Samuel Mengistu on 6/2/23.
//

import XCTest

final class RMEpisodesViewModelTests: XCTestCase {

    private var viewModel: RMEpisodesViewModel!
    
    override func setUpWithError() throws {
        viewModel = .init()
        viewModel.episodesRepo = MockedRMEpisodesRepository()
    }

    func test_fetchEpisodesFirstPage_gets_success_viewState() async {
        await viewModel.fetchEpisodesFirstPage()
        
        XCTAssertEqual(viewModel.viewState, RMViewState.success)
    }
    
    func test_fetchAdditionalEpisodes_gets_more_episodes() async {
        await viewModel.fetchEpisodesFirstPage()
        let count = viewModel.episodes.count
        await viewModel.fetchAdditionalEpisodes()
        
        XCTAssertTrue(count < viewModel.episodes.count)
    }
}

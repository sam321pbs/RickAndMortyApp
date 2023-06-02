//
//  RMCharacterDetailViewViewModelTest.swift
//  RickAndMortyAppUnitTests
//
//  Created by Samuel Mengistu on 6/2/23.
//

import XCTest

final class RMCharacterDetailViewViewModelTest: XCTestCase {

    private var viewModel: RMCharacterDetailViewViewModel!
    
    override func setUpWithError() throws {
        viewModel = .init(character: character)
        viewModel.episodesRepo = MockedRMEpisodesRepository()
    }

    func test_fetchEpisodes_gets_success_viewState() async {
        
        await viewModel.fetchEpisodes()
        
        XCTAssertEqual(viewModel.viewState, RMViewState.success)
    }
    
    func test_fetchEpisodes_has_sections() async {
        
        await viewModel.fetchEpisodes()
        
        XCTAssertEqual(viewModel.sections.count, 3)
    }
}

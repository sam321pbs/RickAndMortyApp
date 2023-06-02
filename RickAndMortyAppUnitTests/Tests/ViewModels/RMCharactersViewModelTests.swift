//
//  RMCharactersViewModelTests.swift
//  RickAndMortyAppUnitTests
//
//  Created by Samuel Mengistu on 6/2/23.
//

import XCTest

final class RMCharactersViewModelTests: XCTestCase {

    private var viewModel: RMCharactersViewModel!
    
    override func setUpWithError() throws {
        viewModel = .init()
        viewModel.charactersRepo = MockedRMCharactersRepository()
    }

    func test_fetchCharacters_gets_success_viewState() async {
        await viewModel.fetchCharacters()
        
        XCTAssertEqual(viewModel.viewState, RMViewState.success)
    }
    
    func test_fetchAddtionalCharacters_gets_more_characters() async {
        await viewModel.fetchCharacters()
        let count = viewModel.characters.count
        await viewModel.fetchAddtionalCharacters()
        
        XCTAssertTrue(count < viewModel.characters.count)
    }
}

//
//  RMLocationDetailViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/1/23.
//

import Combine

@MainActor
final class RMLocationDetailViewModel: ObservableObject {
    
    private var charactersRepo: RMCharactersRepository
    
    @Published var viewState: RMViewState = .initial
    
    public private(set) var sections: [RMLocationDetailViewModel.SectionType] = []
    
    enum SectionType {
        case information(location: [RMLocationInformationUIModel])
        case characters(characters: [RMCharacter])
    }
    
    // MARK: - Init
    
    init(
        charactersRepo: RMCharactersRepository
    ) {
        self.charactersRepo = charactersRepo
    }
    
    // MARK: - Public
    
    func fetchLocationDetails(location: RMLocation) {
        
        let characterIds = getCharacterIds(location: location)
        
        Task.init {
            do {
                let characterResponse = try await charactersRepo.getCharactersByIds(ids: characterIds)
                let sections: [RMLocationDetailViewModel.SectionType] = [
                    .information(location: convertLocationToUIInfo(location: location)),
                    .characters(characters: characterResponse)
                ]
                self.sections = sections
                viewState = .success
            } catch let error {
                print("Error getting Location details")
                viewState = .error(error)
            }
        }
    }
    
    // MARK: - Private
    
    private func getCharacterIds(location: RMLocation) -> [Int] {
        let characterIds: [Int] = location.residents.map {
            if let number = $0.getLastNumberInUrl() {
                return number
            }
            
            return -1
        }.filter { number in number >= 0 }
        
        print("character count \(characterIds.count)")
        
        return characterIds
    }
    
    private func convertLocationToUIInfo(location: RMLocation) -> [RMLocationInformationUIModel] {
        return [
            .init(title: "Location ", value: location.name),
            .init(title: "Type ", value: location.type),
            .init(title: "Dimension ", value: location.dimension),
            .init(title: "Created", value: DateUtils.convertToReadableShortDate(from: location.created))
        ]
    }
}

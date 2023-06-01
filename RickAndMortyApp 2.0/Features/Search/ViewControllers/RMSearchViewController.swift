//
//  RMSearchViewController.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/30/23.
//

import UIKit

// Dynamic search option view
// Render results
// Render no results zero state
// Searching / API call

/// Configurable controller to search
final class RMSearchViewController: UIViewController {
        
    /// Configuration for search session
    struct Config {
        enum `Type` {
            case character // name | status | gender
            case episode // name
            case location // name | type
            
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .location:
                    return "Search Locations"
                case .episode:
                    return "Search Episodes"
                }
            }
        }
        
        let type: `Type`
    }
    
    static let identifier = "RMSearchViewController"
    
    var config: Config!
    
    private let searchView = RMSearchView()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.viewModel = RMSearchViewModel(config: config)
        
        title = config?.type.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Search",
            style: .done,
            target: self,
            action: #selector(didTapExecuteSearch)
        )
        view.addSubview(searchView)
        addConstaints()
        searchView.navigationController = self.navigationController
        searchView.type = config?.type
        searchView.delegate = self
    }
    
    @objc
    private func didTapExecuteSearch() {
        searchView.startSearch()
        self.view.endEditing(true)
    }
    
    private func addConstaints() {
        searchView.translatesAutoresizingMaskIntoConstraints = false
        // margins for staying in safe area
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: margins.topAnchor),
            searchView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
    }
}

extension RMSearchViewController: RMSearchViewDelegate {
    
    func rmSearchView(_ inputView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        var pickerData: [String] = []
        switch option {
        case .gender:
            pickerData = RMCharacterGender.allCases.map { $0.rawValue }
        case .status:
            pickerData = RMCharacterStatus.allCases.map { $0.rawValue }
        case .locationType:
            pickerData = ["Space station", "Planet", "Microverse", "TV", "Resort", "Fantasy Town", "Dream"]
        }
    
        NavigationUtils.navigateToPickerView(
            presentationController: self.presentationController,
            navigationController: self.navigationController,
            pickerData: pickerData,
            onItemSelected: { item in
                if let item = item {
                    inputView.pickerItemSelected(item: item)
                }
            }
        )
    }  
}

//
//  NavigationUtils.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/30/23.
//

import UIKit
import SafariServices
import SwiftUI
import RxSwift

struct NavigationUtils {
    private static var storyBoard: UIStoryboard {
        return  UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func navigateToCharacterDetailsView(navigationController: UINavigationController?, character: RMCharacter) {
        // Goto RMCharacterDetailCollectionViewController
        let detailVC = storyBoard.instantiateViewController(
            withIdentifier: RMCharacterDetailCollectionViewController.identifier
        ) as! RMCharacterDetailCollectionViewController
        detailVC.viewModel = .init(
            character: character,
            episodesRepo: RMEpisodesRepositoryImpl(dataSouce: RMEpisodesDataSourceImpl())
        )
        detailVC.navigationItem.largeTitleDisplayMode = .never
        
        navigate(navigationController: navigationController, viewController: detailVC)
    }
    
    static func navigateToEpisodeDetailsView(navigationController: UINavigationController?, episode: RMCharacterDetailsEpisodeUIModel) {
        // Goto RMCharacterDetailCollectionViewController
        let detailVC = storyBoard.instantiateViewController(
            withIdentifier: RMEpisodeDetailViewController.identifier
        ) as! RMEpisodeDetailViewController
        detailVC.episodeUrl = episode.episodeUrl
        detailVC.navigationItem.largeTitleDisplayMode = .never
        
        navigate(navigationController: navigationController, viewController: detailVC)
    }
    
    static func navigateToSearchView(navigationController: UINavigationController?, config: RMSearchViewController.Config) {
        // Goto RMCharacterDetailCollectionViewController
        let searchVC = storyBoard.instantiateViewController(
            withIdentifier: RMSearchViewController.identifier
        ) as! RMSearchViewController
        searchVC.navigationItem.largeTitleDisplayMode = .never
        searchVC.config = config
        navigate(navigationController: navigationController, viewController: searchVC)
    }
    
    static func navigateToLocationDetailView(
        navigationController: UINavigationController?,
        location: RMLocation
    ) {
        // Goto RMLocationDetailViewController
        let detailVC = storyBoard.instantiateViewController(
            withIdentifier: RMLocationDetailViewController.identifier
        ) as! RMLocationDetailViewController
        
        detailVC.navigationItem.largeTitleDisplayMode = .never
        detailVC.location = location
        
        navigate(navigationController: navigationController, viewController: detailVC)
    }
    
    static func navigateToPickerView(
        presentationController: UIPresentationController?,
        navigationController: UINavigationController?,
        pickerData: [String],
        onItemSelected: @escaping (String?) -> Void
    ) {
        // Goto RMPickerViewController
        let pickerVC = RMPickerViewController()
        
        pickerVC.navigationItem.largeTitleDisplayMode = .never
        pickerVC.viewModel.pickerData = pickerData
        pickerVC.viewModel.selectedItem.subscribe(onNext: { item in
            onItemSelected(item)
        })
        
        guard let navigationController = navigationController else {
            print("controllers are nil")
            return
        }
        
        
        let nav = UINavigationController(rootViewController: pickerVC)
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        navigationController.present(nav, animated: true, completion: nil)
    }
    
    private static func navigate(
        navigationController: UINavigationController?,
        viewController: UIViewController
    ) {
        guard let navigationController = navigationController else {
            print("navigation cotroller is nil")
            return
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension NavigationUtils {
    static func navigateToWebsite(navigationController: UIViewController, url: URL) {
        let vc = SFSafariViewController(url: url)
        navigationController.present(vc, animated: true)
    }
}

//
//  RMEpisodeDetailViewController.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/27/23.
//

import UIKit
import Combine

class RMEpisodeDetailViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    static let identifier = "RMEpisodeDetailViewController"
    
    let viewModel: RMEpisodeDetailViewModel = .init()
    
    var episodeUrl: String?
    
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Episode"
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCompositionalLayout()
        registerCells()
        setupViewModel()
        fetchEpisodes()
    }
    
    private func setupViewModel() {
        cancellable = viewModel.$viewState.sink { [weak self] state in
            guard let me = self else { return }
            me.onViewStateUpdated(state)
        }
    }
    
    private func fetchEpisodes() {
        Task.init {
            if let episodeNumber = episodeUrl?.getLastNumberInUrl() {
                print(episodeNumber)
                await viewModel.fetchEpisodeDetails(episodeId: episodeNumber)
            }
        }
    }
    
    private func registerCells() {
        collectionView.register(
            RMEpisodeInfoCollectionViewCell.nib(),
            forCellWithReuseIdentifier: RMEpisodeInfoCollectionViewCell.identifier
        )
        
        collectionView.register(
            RMCharacterCollectionViewCell.nib(),
            forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier
        )
    }
    
    private func setupCompositionalLayout() {
        // How the cells are presented in groups
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.layout(for: sectionIndex)
        }
    }
    
    @objc
    private func didTapShare() {
        print("Tapped share")
        guard let navigationController = self.navigationController, let url = episodeUrl else {
            return
        }
        ShareUtils.shareLink(navigationController: navigationController, link: url)
    }
    
    private func onViewStateUpdated(_ state: RMViewState) {
        switch state {
        case .initial:
            print()
        case .loading:
            collectionView.isHidden = true
            collectionView.alpha = 0
            spinner.startAnimating()
        case .success:
            collectionView.isHidden = false
            collectionView.alpha = 1
            spinner.stopAnimating()
            collectionView.reloadData()
        case.error(let error):
            print(error)
            spinner.stopAnimating()
        }
    }
}

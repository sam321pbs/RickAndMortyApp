//
//  RMEpisodeViewController.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import UIKit
import Combine

final class RMEpisodeViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let viewModel: RMEpisodesViewModel = .init()
    
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        view.backgroundColor = .systemBackground
        setupCollectionLayout()
        addSearchButton()
        
        setupViewModel()
        fetchData()
    }
    
    // MARK: - Private
    
    private func fetchData() {
        Task.init {
            await viewModel.fetchEpisodesFirstPage()
        }
    }
    
    private func setupViewModel() {
        cancellable = viewModel.$viewState.sink { [weak self] state in
            guard let me = self else { return }
            me.onViewStateUpdated(state)
        }
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch() {
        NavigationUtils.navigateToSearchView(
            navigationController: self.navigationController,
            config: .init(type: .episode)
        )
    }
    
    private func setupCollectionLayout() {
        collectionView.register(
            RMEpisodeCollectionViewCell.nib(),
            forCellWithReuseIdentifier: RMEpisodeCollectionViewCell.identifier
        )
        
        collectionView.register(
            RMFooterLoadingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // How the cells are presented
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = layout
    }
    
    private func onViewStateUpdated(_ state: RMViewState) {
        switch state {
        case .initial:
            print()
        case .loading:
            spinner.startAnimating()
            collectionView.isHidden = true
        case .success:
            spinner.stopAnimating()
            collectionView.isHidden = false
            collectionView.reloadData()
            UIView.animate(withDuration: 0.4) {
                self.collectionView.alpha = 1
            }
        case .error(let error):
            print(error)
            spinner.stopAnimating()
            collectionView.isHidden = true
        }
    }
}


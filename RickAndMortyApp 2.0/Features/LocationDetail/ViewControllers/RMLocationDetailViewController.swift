//
//  RMLocationDetailViewController.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/1/23.
//

import UIKit
import Combine

class RMLocationDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
        
    var location: RMLocation?
    
    static let identifier = "RMLocationDetailViewController"
    
    public private(set) var viewModel: RMLocationDetailViewModel!
    
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Location"
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        viewModel = .init(
                charactersRepo: RMCharactersRepositoryImpl(dataSouce: RMCharactersDataSourceImpl())
            )
        
        cancellable = viewModel.$viewState.sink { [weak self] state in
            guard let me = self else { return }
            me.onViewStateUpdated(state)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCompositionalLayout()
        registerCells()
        
        if let location = location {
            viewModel.fetchLocationDetails(location: location)
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
        guard let navigationController = self.navigationController, let url = location?.url else {
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

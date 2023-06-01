//
//  RMCharacterViewController.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import UIKit
import Alamofire
import Combine

final class RMCharacterViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let viewModel: RMCharactersViewModel = .init()
    
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setupCollectionLayout()
        addSearchButton()
        
        setupViewModel()
    }
    
    // MARK: - Private
    
    private func setupViewModel() {
        cancellable = viewModel.$viewState.sink { [weak self] state in
            guard let me = self else { return }
            me.updateViewFromState(state)
        }
        
        viewModel.fetchCharacters()
    }
    
    private func updateViewFromState(_ state: RMViewState) {
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
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch() {
        NavigationUtils.navigateToSearchView(
            navigationController: self.navigationController,
            config: .init(type: .character)
        )
    }
    
    /// This will register the cells needed and set the number of rows for the collection view
    private func setupCollectionLayout() {
        collectionView.register(
            RMCharacterCollectionViewCell.nib(),
            forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier
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
}


//
//  RMSearchView.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/1/23.
//

import UIKit
import Combine

protocol RMSearchViewDelegate: AnyObject {
    func rmSearchView(
        _ inputView: RMSearchView,
        didSelectOption option: RMSearchInputViewViewModel.DynamicOption
    )
}

class RMSearchView: UIView {
    
    weak var navigationController: UINavigationController?
    
    weak var presentationController: UIPresentationController?
    
    weak var delegate: RMSearchViewDelegate?
    
    private let noSearchResultsView = RMNoSearchResultsView()
    
    private let searchInputView = RMSearchInputView()
    
    private var cancellable: AnyCancellable?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var collectionView: UICollectionView = {
        // How the cells are presented
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }()
    
    var type: RMSearchViewController.Config.`Type`? {
        didSet {
            searchInputView.viewModel = RMSearchInputViewViewModel(type: type)
        }
    }
    
    var viewModel: RMSearchViewModel! {
        didSet {
            cancellable = viewModel.$viewState.sink { [weak self] state in
                guard let me = self else { return }
                me.onViewStateUpdated(state)
            }
        }
    }
    
    private var selectedOption: RMSearchInputViewViewModel.DynamicOption?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        searchInputView.delegate = self
        addSubviews(
            noSearchResultsView,
            searchInputView,
            collectionView,
            spinner
        )
        
        setupCollectionLayout()
        addConstraints()
        
        collectionView.isHidden = true
        noSearchResultsView.isHidden = true
        searchInputView.searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @discardableResult func loadNib() -> UIView {
        let view = Bundle.main.loadNibNamed(
            "RMSearchView",
            owner: self,
            options: nil
        )?.first as? UIView
        
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.frame = bounds
        addSubview(view!)
        
        return view!
    }
    
    func startSearch() {
        viewModel.startSearch(searchText: searchInputView.searchBar.text)
    }
    
    // MARK: - private
    
    private func setupCollectionLayout() {
        collectionView.register(
            RMCharacterCollectionViewCell.nib(),
            forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier
        )
        
        collectionView.register(
            RMEpisodeCollectionViewCell.nib(),
            forCellWithReuseIdentifier: RMEpisodeCollectionViewCell.identifier
        )
        
        collectionView.register(
            RMSearchLocationCollectionViewCell.nib(),
            forCellWithReuseIdentifier: RMSearchLocationCollectionViewCell.identifier
        )
        
        collectionView.register(
            RMFooterLoadingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func addConstraints() {
        noSearchResultsView.translatesAutoresizingMaskIntoConstraints = false
        searchInputView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // search input view
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: 110),
            
            // No results
            noSearchResultsView.widthAnchor.constraint(equalToConstant: 150),
            noSearchResultsView.heightAnchor.constraint(equalToConstant: 150),
            noSearchResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noSearchResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // collection view
            collectionView.topAnchor.constraint(equalTo: searchInputView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // spinner
            spinner.widthAnchor.constraint(equalToConstant: 150),
            spinner.heightAnchor.constraint(equalToConstant: 150),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
    
    private func onViewStateUpdated(_ state: RMViewState) {
        switch state {
        case .initial:
            print()
        case .loading:
            spinner.startAnimating()
        case .success:
            if viewModel.count == 0 {
                collectionView.isHidden = true
                noSearchResultsView.isHidden = false
                
            } else {
                collectionView.isHidden = false
                noSearchResultsView.isHidden = true
                collectionView.reloadData()
            }
            spinner.stopAnimating()
        case .error:
            collectionView.isHidden = true
            noSearchResultsView.isHidden = false
            spinner.stopAnimating()
        }
    }
}

// MARK: - RMSearchInputViewDelegate

extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        selectedOption = option
        delegate?.rmSearchView(self, didSelectOption: option)
        
    }
}

extension RMSearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.startSearch(searchText: searchBar.text)
    }
}

extension RMSearchView {
    func pickerItemSelected(item: String) {
        
        switch selectedOption {
        case .gender:
            RMCharacterGender.allCases.forEach { gender in
                if gender.rawValue.lowercased() == item.lowercased() {
                    viewModel.startSearch(searchText: searchInputView.searchBar.text, gender: gender)
                }
            }
            
        case .status:
            RMCharacterStatus.allCases.forEach { status in
                if status.rawValue.lowercased() == item.lowercased() {
                    viewModel.startSearch(searchText: searchInputView.searchBar.text, status: status)
                }
            }
        case .locationType:
            viewModel.startSearch(searchText: searchInputView.searchBar.text, locationType: item)
        case .none:
            return
        }
    }
}

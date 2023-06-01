//
//  RMCharacterDetailCollectionViewController.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/25/23.
//

import UIKit
import Combine

final class RMCharacterDetailCollectionViewController: UICollectionViewController {
    
    static let identifier = "RMCharacterDetailCollectionViewController"
    
    var viewModel: RMCharacterDetailViewViewModel!
    
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = viewModel.character.name
        
        cancellable = viewModel.$viewState.sink { [weak self] state in
            self?.render(state: state)
        }
        
        registerCellViews()
        
        setupCompositionalLayout()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    private func render(state: RMViewState) {
        switch state {
        case .success:
            episodesLoaded()
        case .initial, .loading, .error:
            return
        }
    }
    
    @objc
    private func didTapShare() {
        print("Tapped share")
        guard let navigationController = self.navigationController else {
            return
        }
        ShareUtils.shareLink(navigationController: navigationController, link: viewModel.character.url)
    }
    
    private func setupCompositionalLayout() {
        // How the cells are presented in groups
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
    }
    
    func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = viewModel.sections[sectionIndex]
        
        switch section {
        case .photo:
            return createPhotoSectionLayout()
        case .information:
            return createInformationSectionLayout()
        case .episodes:
            return createEpisodeSectionLayout()
        }
    }
    
    private func createPhotoSectionLayout()-> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createInformationSectionLayout()-> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)
                )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createEpisodeSectionLayout()-> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func registerCellViews() {
        collectionView.register(
            RMCharacterDetailImageCollectionViewCell.nib(),
            forCellWithReuseIdentifier: RMCharacterDetailImageCollectionViewCell.identifier
        )
        
        collectionView.register(
            RMCharacterDetailInformationCollectionViewCell.nib(),
            forCellWithReuseIdentifier: RMCharacterDetailInformationCollectionViewCell.identifier
        )
        
        collectionView.register(
            RMEpisodeCollectionViewCell.nib(),
            forCellWithReuseIdentifier: RMEpisodeCollectionViewCell.identifier
        )
    }
    
    
    // MARK: - CollectionView
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
       
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .photo, .information:
            print()
        case .episodes(let episodes):
            NavigationUtils.navigateToEpisodeDetailsView(
                navigationController: self.navigationController,
                episode: episodes[indexPath.row]
            )
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        
        switch section {
        case .photo:
            return 1
        case .information(let characterInfo):
            return characterInfo.count
        case .episodes(let episodes):
            return episodes.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .photo(let imageUrl):
            // hook up the cell with the data
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterDetailImageCollectionViewCell.identifier,
                for: indexPath
            ) as! RMCharacterDetailImageCollectionViewCell
            
            cell.configure(imageUrl: imageUrl)
            return cell
        case .information(let characterInfo):
            // hook up the cell with the data
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterDetailInformationCollectionViewCell.identifier,
                for: indexPath
            ) as! RMCharacterDetailInformationCollectionViewCell
            
            cell.configure(information: characterInfo[indexPath.row])
            return cell
        case .episodes(let episode):
            // hook up the cell with the data
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeCollectionViewCell.identifier,
                for: indexPath
            ) as! RMEpisodeCollectionViewCell
            
            cell.configure(episode: episode[indexPath.row])
            return cell
        }
    }
    
    private func episodesLoaded() {
        collectionView.reloadData()
    }
}

//
//  RMEpisodeDetailViewControllerExtension.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/30/23.
//

import UIKit

extension RMEpisodeDetailViewController {
    
    func layout(for section: Int) -> NSCollectionLayoutSection {
        switch viewModel.sections[section] {
        case .information:
            return createInfoLayout()
        case .characters:
            return createCharacterLayout()
        }
    }
    
    func createInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(90)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createCharacterLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)
                )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(260)
            ),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

extension RMEpisodeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .information(let episode):
            return episode.count
        case .characters(let characters):
            return characters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .information(let episode):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeInfoCollectionViewCell.identifier,
                for: indexPath
            ) as! RMEpisodeInfoCollectionViewCell
            
            cell.configure(uiModel: episode[indexPath.row])
            return cell
        case .characters(let characters):
            // hook up the cell with the data
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterCollectionViewCell.identifier,
                for: indexPath
            ) as! RMCharacterCollectionViewCell
            
            cell.configure(with: characters[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        switch viewModel.sections[indexPath.section] {
        case .information:
            return
        case .characters(let characters):
            NavigationUtils.navigateToCharacterDetailsView(
                navigationController: self.navigationController,
                character: characters[indexPath.row]
            )
            return
        }
    }
}

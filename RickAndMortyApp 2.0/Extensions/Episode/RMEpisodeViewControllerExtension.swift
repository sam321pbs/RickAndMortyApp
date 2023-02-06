//
//  RMEpisodeViewControllerExtension.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/28/23.
//

import UIKit

extension RMEpisodeViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("selected item")
        NavigationUtils.navigateToEpisodeDetailsView(
            navigationController: self.navigationController,
            episode: viewModel.episodes[indexPath.row]
        )
    }
}

extension RMEpisodeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // hook up the cell with the data
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMEpisodeCollectionViewCell.identifier,
            for: indexPath
        ) as! RMEpisodeCollectionViewCell
        
        cell.configure(episode: viewModel.episodes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // set up the footer spinner
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
    
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.episodes.count - 1) && !(viewModel.isLoadingMore) {
            // fetch more when we reach the bottom
            viewModel.fetchAdditionalEpisodes()
        }
    }
}

// Currently using this for sizing the cells in the collection view
extension RMEpisodeViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = bounds.width - 20
        return CGSize(
            width: width,
            height: 100
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if !viewModel.isLoadingMore {
            return .zero
        }
        return CGSize(
            width: collectionView.frame.width,
            height: 100
        )
    }
}

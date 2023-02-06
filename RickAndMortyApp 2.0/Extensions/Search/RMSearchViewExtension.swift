//
//  RMSearchViewExtension.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/2/23.
//

import UIKit

extension RMSearchView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch viewModel.config.type {
        case .character:
            NavigationUtils.navigateToCharacterDetailsView(
                navigationController: self.navigationController,
                character: viewModel.characters[indexPath.row]
            )
        case .episode:
            NavigationUtils.navigateToEpisodeDetailsView(
                navigationController: self.navigationController,
                episode: viewModel.episodes[indexPath.row].convertToUIModel()
            )
        case .location:
            NavigationUtils.navigateToLocationDetailView(
                navigationController: self.navigationController,
                location: viewModel.locations[indexPath.row]
            )
        }
        
    }
}

extension RMSearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // hook up the cell with the data
        
        switch viewModel.config.type {
        case .character:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterCollectionViewCell.identifier,
                for: indexPath
            ) as! RMCharacterCollectionViewCell
            
            cell.configure(with: viewModel.characters[indexPath.row])
            return cell
        case .episode:
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeCollectionViewCell.identifier,
                for: indexPath
            ) as! RMEpisodeCollectionViewCell
            
            cell.configure(episode: viewModel.episodes[indexPath.row].convertToUIModel())
            
            return cell
        case .location:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMSearchLocationCollectionViewCell.identifier,
                for: indexPath
            ) as! RMSearchLocationCollectionViewCell
            
            cell.configure(location: viewModel.locations[indexPath.row])
            
            return cell
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        // set up the footer spinner
    //        guard kind == UICollectionView.elementKindSectionFooter,
    //              let footer = collectionView.dequeueReusableSupplementaryView(
    //                ofKind: kind,
    //                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
    //                for: indexPath
    //              ) as? RMFooterLoadingCollectionReusableView else {
    //            fatalError("Unsupported")
    //        }
    //
    //        footer.startAnimating()
    //        return footer
    //    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        if (indexPath.row == viewModel.characters.count - 1) && !viewModel.isLoadingAdditionalCharacters {
        //            // fetch more when we reach the bottom
        //            viewModel.fetchAddtionalCharacters()
        //        }
    }
}

// Currently using this for sizing the cells in the collection view
extension RMSearchView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.config.type {
        case .character:
            let bounds = UIScreen.main.bounds
            let width = (bounds.width - 30)/2
            let height = (width * 1.5)
            return CGSize(
                width: width,
                height: height
            )
        case .episode:
            return CGSize(
                width: collectionView.frame.width,
                height: 100
            )
        case .location:
            return CGSize(
                width: collectionView.frame.width,
                height: 100
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        //        guard !viewModel.isLoadingAdditionalCharacters else {
        //            return .zero
        //        }
        
        
        return CGSize(
            width: collectionView.frame.width,
            height: 100
        )
    }
}

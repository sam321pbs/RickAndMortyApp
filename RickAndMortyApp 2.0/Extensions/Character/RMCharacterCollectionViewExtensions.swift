//
//  RMCharacterCollectionViewExtensions.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/25/23.
//

import UIKit

// For view interaction
extension RMCharacterViewController: UICollectionViewDelegate { 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        NavigationUtils.navigateToCharacterDetailsView(navigationController: self.navigationController, character: viewModel.characters[indexPath.row])
    }
}

extension RMCharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // hook up the cell with the data
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.identifier,
            for: indexPath
        ) as! RMCharacterCollectionViewCell
        
        cell.configure(with: viewModel.characters[indexPath.row])
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
        if (indexPath.row == viewModel.characters.count - 1) && !viewModel.isLoadingAdditionalCharacters {
            // fetch more when we reach the bottom
            viewModel.fetchAddtionalCharacters()
        }
    }
}

// Currently using this for sizing the cells in the collection view
extension RMCharacterViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        let height = (width * 1.5)
        return CGSize(
            width: width,
            height: height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard !viewModel.isLoadingAdditionalCharacters else {
            return .zero
        }
        return CGSize(
            width: collectionView.frame.width,
            height: 100
        )
    }
}

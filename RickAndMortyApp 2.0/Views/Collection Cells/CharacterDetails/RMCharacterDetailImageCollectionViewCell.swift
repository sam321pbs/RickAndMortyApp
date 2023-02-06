//
//  RMCharacterDetailImageCollectionViewCell.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/25/23.
//

import UIKit

class RMCharacterDetailImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    
    static let identifier = "RMCharacterDetailImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            characterImageView.kf.setImage(with: url)
        }
    }
}

//
//  RMCharacterCollectionViewCell.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import UIKit
import Kingfisher

class RMCharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet var characterImageView: UIImageView!
    
    @IBOutlet weak var characterNameLabel: UILabel!
    
    @IBOutlet weak var characterStatus: UILabel!
    
    static let identifier = "RMCharacterCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with character: RMCharacter) {
        if let url = URL(string: character.image) {
            characterImageView.kf.setImage(with: url)
        }
        
        characterStatus.text = "Status: " + character.status.rawValue
        characterNameLabel.text = character.name
        layer.cornerRadius = 5
        layer.masksToBounds = true
        dropShadow()
    }

    static func nib() -> UINib {
     return UINib(nibName: identifier, bundle: nil)
    }
}

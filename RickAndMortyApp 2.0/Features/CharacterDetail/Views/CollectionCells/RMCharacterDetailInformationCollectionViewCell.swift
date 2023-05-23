//
//  RMCharacterDetailInformationCollectionViewCell.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/25/23.
//

import UIKit

class RMCharacterDetailInformationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bellIcon: UIImageView!
    
    @IBOutlet weak var primaryLabel: UILabel!
    
    @IBOutlet weak var secondaryLabel: UILabel!
    
    static let identifier = "RMCharacterDetailInformationCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(information: RMCharacterDetailInformationUIModel) {
        primaryLabel.text = information.text
        secondaryLabel.text = information.type.displayTitle
        secondaryLabel.textColor = information.type.color
        bellIcon.tintColor = information.type.color
        layer.cornerRadius = 5
        layer.masksToBounds = true
        dropShadow()
    }
}

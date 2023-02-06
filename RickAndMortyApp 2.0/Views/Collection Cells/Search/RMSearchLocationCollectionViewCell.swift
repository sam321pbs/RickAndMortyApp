//
//  RMSearchLocationCollectionViewCell.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/2/23.
//

import UIKit

class RMSearchLocationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var dimensionLabel: UILabel!
    
    static let identifier = "RMSearchLocationCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    func configure(location: RMLocation) {
//        accessoryType = .disclosureIndicator
        locationLabel.text = "Planet " + location.name
        typeLabel.text = "Type: " + location.type
        dimensionLabel.text = location.dimension
    }
}

//
//  RMEpisodeInfoCollectionViewCell.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import UIKit

class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    static let identifier = "RMEpisodeInfoCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(uiModel: RMEpisodeInformationUIModel) {
        titleLabel.text = uiModel.title
        valueLabel.text = uiModel.value
        setupBorder()
    }
    
    func configure(uiModel: RMLocationInformationUIModel) {
        titleLabel.text = uiModel.title
        valueLabel.text = uiModel.value
        setupBorder()
    }
    
    private func setupBorder() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }

}

//
//  RMCharacterDetailEpisodeCollectionViewCell.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

import UIKit

class RMEpisodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var episodeNumberLabel: UILabel!
    
    @IBOutlet weak var episodeNameLabel: UILabel!
    
    @IBOutlet weak var airDateLabel: UILabel!
    
    static let identifier = "RMEpisodeCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(episode: RMCharacterDetailsEpisodeUIModel) {
        episodeNumberLabel.text = "Episode " + episode.episode
        episodeNameLabel.text = episode.name
        airDateLabel.text = "Aired on " + episode.air_date
        setBorderColor(borderColor: episode.borderColor)
        dropShadow()
    }
    
    private func setBorderColor(borderColor: UIColor) {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 1.0
    }
}

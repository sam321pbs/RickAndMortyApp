//
//  RMLocationTableViewCell.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var dimensionLabel: UILabel!
    
    static let identifier = "RMLocationTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(location: RMLocation) {
        accessoryType = .disclosureIndicator
        locationLabel.text = "Planet " + location.name
        typeLabel.text = "Type: " + location.type
        dimensionLabel.text = location.dimension
    }
    
}

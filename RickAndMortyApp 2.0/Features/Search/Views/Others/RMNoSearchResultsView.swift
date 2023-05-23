//
//  RMNoSearchResultsView.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/1/23.
//

import UIKit

class RMNoSearchResultsView: UIView {

    @IBOutlet weak var noResultsLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @discardableResult func loadNib() -> UIView {
        let view = Bundle.main.loadNibNamed(
            "RMNoSearchResultsView",
            owner: self,
            options: nil
        )?.first as? UIView
        
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.frame = bounds
        addSubview(view!)
        return view!
    }
}

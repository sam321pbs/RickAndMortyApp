//
//  Footer.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/24/23.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
        static let identifier = "RMFooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(spinner)
        addConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstaints() {
        NSLayoutConstraint.activate([
        spinner.widthAnchor.constraint(equalToConstant: 100),
        spinner.heightAnchor.constraint(equalToConstant: 100),
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}

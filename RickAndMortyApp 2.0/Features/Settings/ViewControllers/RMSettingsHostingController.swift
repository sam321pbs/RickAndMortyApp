//
//  RMSettingsViewController.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import SafariServices
import SwiftUI
import UIKit
import StoreKit

final class RMSettingsHostingController: UIHostingController<RMSettingsView> {
    
    private var viewModel: RMSettingsViewViewModel!
    
    required init?(coder: NSCoder) {
        viewModel = RMSettingsViewViewModel()
        super.init(coder: coder, rootView: RMSettingsView(viewModel: self.viewModel));
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setTapHandler() { [weak self] option in
            self?.handleTap(option: option)
        }
    }
    
    private func handleTap(option: RMSettingsOption) {
        
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.targetUrl {
            // open website
            NavigationUtils.navigateToWebsite(navigationController: self, url: url)
        } else if option == .rateApp {
            // Show rating prompt
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}

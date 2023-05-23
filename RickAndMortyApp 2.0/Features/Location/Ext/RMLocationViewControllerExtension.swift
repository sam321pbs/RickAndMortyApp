//
//  RMLocationViewControllerExtension.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import UIKit

extension RMLocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let location = viewModel.locations[indexPath.row]
        
        NavigationUtils.navigateToLocationDetailView(navigationController: self.navigationController, location: location)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.locations.count - 1) && !(viewModel.isLoadingMore) {
            // fetch more when we reach the bottom
            viewModel.fetchAdditionalLocations()
        }
    }
}

extension RMLocationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: RMLocationTableViewCell.identifier,
            for: indexPath
        ) as! RMLocationTableViewCell
        
        cell.configure(location: viewModel.locations[indexPath.row])
        return cell
    }
    

}

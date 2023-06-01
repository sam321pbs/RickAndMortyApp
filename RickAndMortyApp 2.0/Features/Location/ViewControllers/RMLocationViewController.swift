//
//  RMLocationViewController.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import UIKit
import Combine

final class RMLocationViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var cancellable: AnyCancellable?
    
    var viewModel: RMLocationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Location"
        
        addSearchButton()
        
        configureTableView()
        setupViewModel()
    }
    
    // MARK: - Private
    
    private func setupViewModel() {
        viewModel = RMLocationViewModel(
            repo: RMLocationRepositoryImpl(
                dataSouce: RMLocationDataSourceImpl()
            )
        )
        
        cancellable = viewModel.$viewState.sink { [weak self] state in
            guard let me = self else { return }
            me.onViewStateUpdated(state: state)
        }
        
        viewModel.fetchLocations()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            RMLocationTableViewCell.nib(),
            forCellReuseIdentifier: RMLocationTableViewCell.identifier
        )
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch() {
        NavigationUtils.navigateToSearchView(
            navigationController: self.navigationController,
            config: .init(type: .location)
        )
    }
    
    private func onDataSet() {
        spinner.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
        print(viewModel.locations.count)
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = 1
        }
    }
    
    private func onViewStateUpdated(state: RMViewState) {
        switch state {
        case .initial:
            print()
        case .loading:
            spinner.startAnimating()
        case .success:
            onDataSet()
        case .error(let error):
            print(error)
        }
    }
}


//
//  RMPickerViewController.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/3/23.
//

import UIKit

class RMPickerViewController: UIViewController {
    
    private let pickerView = UIPickerView()
    
    let viewModel: RMPickerViewViewModel = RMPickerViewViewModel()
    
    static let identifier = "RMPickerViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .tertiarySystemBackground
        view.addSubviews(pickerView)
        addConstraints()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
    }
    
    private func addConstraints() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false

        pickerView.backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: view.topAnchor),
            pickerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

extension RMPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.pickerData[row]
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectedItem.accept(viewModel.pickerData[row])
    }
}

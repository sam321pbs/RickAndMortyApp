//
//  RMPickerViewViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/6/23.
//

import Combine

final class RMPickerViewViewModel: ObservableObject {
    
    var pickerData: [String] = []
    
    @Published var selectedItem: String? = nil
}

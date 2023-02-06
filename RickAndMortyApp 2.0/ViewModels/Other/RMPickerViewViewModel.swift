//
//  RMPickerViewViewModel.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/6/23.
//

import RxCocoa

final class RMPickerViewViewModel {
    
    var pickerData: [String] = []
    
    var selectedItem: BehaviorRelay<String?> = BehaviorRelay(value: nil)
}

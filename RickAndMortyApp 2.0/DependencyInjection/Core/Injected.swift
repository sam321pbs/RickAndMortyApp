//
//  Injected.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 6/1/23.
//

import Foundation

@propertyWrapper
struct Injected<T> {
    
    private let keyPath: WritableKeyPath<InjectedValues, T>
    
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }
    
    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}

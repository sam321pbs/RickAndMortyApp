//
//  InjectionKey.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 6/1/23.
//

import Foundation

public protocol InjectionKey {

    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The default value for the dependency injection key.
    static var currentValue: Self.Value { get set }
}

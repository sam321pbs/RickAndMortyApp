//
//  ColorUtils.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/30/23.
//

import UIKit

struct ColorUtils {
    static let borderColors: [UIColor] = [
        .systemBlue,
        .systemGreen,
        .systemOrange,
        .systemRed,
        .systemPink,
        .systemPurple,
        .systemYellow,
        .systemBrown,
        .systemMint,
        .systemTeal,
        .systemIndigo,
        .systemCyan
    ]
    
    static var randomColor: UIColor {
        return borderColors.randomElement() ?? .systemBlue
    }
}

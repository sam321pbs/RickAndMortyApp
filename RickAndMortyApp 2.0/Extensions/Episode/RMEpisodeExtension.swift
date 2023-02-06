//
//  RMEpisodeExtension.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/28/23.
//

import UIKit

extension RMEpisode {
    func convertToUIModel() -> RMCharacterDetailsEpisodeUIModel {
        return RMCharacterDetailsEpisodeUIModel(
            name: self.name,
            air_date: self.air_date,
            episode: self.episode,
            episodeUrl: self.url,
            borderColor: ColorUtils.randomColor
        )
    }
}

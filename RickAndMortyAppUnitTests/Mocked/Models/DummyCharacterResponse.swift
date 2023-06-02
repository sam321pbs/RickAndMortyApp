//
//  DummyCharacterResponse.swift
//  RickAndMortyAppUnitTests
//
//  Created by Samuel Mengistu on 6/2/23.
//

import Foundation

let charactersResponse = RMCharactersResponse(
    info: RMCharactersResponse.Info(
        count: 51,
        pages: 3,
        next: "https://rickandmortyapi.com/api/character/?page=2",
        prev: nil
    ),
    results: [
        character
    ])

let character = RMCharacter(
    id: 1,
    name: "Rick Sanchez",
    status: RMCharacterStatus.alive,
    species: "Human",
    type: "",
    gender: RMCharacterGender.male,
    origin: RMOrigin(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"),
    location: RMSingleLocation(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"),
    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
    episode: [
        "https://rickandmortyapi.com/api/episode/1",
        "https://rickandmortyapi.com/api/episode/2"
    ],
    url: "https://rickandmortyapi.com/api/character/1",
    created: "2017-11-04T18:48:46.250Z"
)

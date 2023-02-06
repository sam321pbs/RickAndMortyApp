//
//  RMApi.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import Foundation
import Alamofire

struct RMApi {
    
    /// API Constants
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    // MARK: characters
    
    /// Creates a request for all characters
    /// - Returns: an alamofire request for all characters
    static func getCharactersByPageDataRequest(page: Int = 1) -> DataRequest {
        return getByPageDataRequest(
            from: RMEndpoint.character,
            page: page
        )
    }
    
    static func getCharactersByIdsDataRequest(ids: [Int]) -> DataRequest {
        return getByIdsDataRequest(endpoint: .character, ids: ids)
    }
    
    static func getCharactersWithFiltersDataRequest(
        name: String?,
        status: RMCharacterStatus?,
        gender: RMCharacterGender?
    ) -> DataRequest {
        var parameter: [String:String] = [:]
        if let name = name {
            parameter["name"] = name
        }
        if let status = status {
            parameter["status"] = status.rawValue
        }
        
        if let gender = gender {
            parameter["gender"] = gender.rawValue
        }
        
        return createRequest(
            from: .character,
            with: parameter
        )
    }
    

    // MARK: episodes
    
    /// Creates a request for all episodes
    /// - Returns: an alamofire request for all episodes
    static func getEpisodesByPageDataRequest(page: Int = 1) -> DataRequest {
        return getByPageDataRequest(
            from: .episode,
            page: page
        )
    }
    
    static func getEpisodesByIdsDataRequest(ids: [Int]) -> DataRequest {
        return getByIdsDataRequest(endpoint: .episode, ids: ids)
    }
    
    static func getEpisodesWithFiltersDataRequest(
        name: String?
    ) -> DataRequest {
        var parameter: [String:String] = [:]
        if let name = name {
            parameter["name"] = name
        }
        
        return createRequest(
            from: .episode,
            with: parameter
        )
    }
    
    // MARK: locations
    
    /// Creates a request for all episodes
    /// - Returns: an alamofire request for all episodes
    static func getLocationsByPageDataRequest(page: Int = 1) -> DataRequest {
        return getByPageDataRequest(
            from: .location,
            page: page
        )
    }
    
    static func getLocationsByIdsDataRequest(ids: [Int]) -> DataRequest {
        return getByIdsDataRequest(endpoint: .location, ids: ids)
    }
    
    static func getLocationsWithFiltersDataRequest(
        name: String?,
        type: String?
    ) -> DataRequest {
        var parameter: [String:String] = [:]
        if let name = name {
            parameter["name"] = name
        }
        if let type = type {
            parameter["type"] = type
        }
        return createRequest(
            from: .location,
            with: parameter
        )
    }
    
    // MARK: Private
    
    /// Creates a request with all object ids included
    /// - Parameters:
    ///   - endpoint: where to get the objects from
    ///   - ids: object ids
    /// - Returns: an alamofire data request
    static func getByIdsDataRequest(endpoint: RMEndpoint, ids: [Int]) -> DataRequest {
        var idsAsString: String? = nil
        if ids.count == 0 {
            idsAsString = nil
        } else if ids.count == 1 {
            idsAsString = String(ids[0])
        } else {
            idsAsString = ids.map{ String(describing: $0) }.joined(separator: ",")
        }
        
        return createRequest(
            from: endpoint,
            additional: idsAsString
        )
    }
    
    /// Creates a request by page
    /// - Returns: an alamofire request
    static func getByPageDataRequest(from endpoint: RMEndpoint, page: Int = 1) -> DataRequest {
        return createRequest(
            from: endpoint,
            with: ["page": String(describing: page)]
        )
    }
    
    /// Used to create Alamofire requests for the Rick and Morty endpoint
    /// - Parameters:
    ///   - endpoint: endpoint destination
    ///   - quaryParameters: parameters for the query
    ///   - parameter: parameter to add to end Ex. characters, episodes
    /// - Returns: a request
    private static func createRequest(
        from endpoint: RMEndpoint,
        with quaryParameters: Parameters? = nil,
        additional parameter: String? = nil
    ) -> DataRequest {
        var additionalParameter = ""
        if let parameter = parameter {
            additionalParameter = "/" + parameter
        }
        
        return AF.request(
            Constants.baseURL + "/" + endpoint.rawValue + additionalParameter,
            method: .get,
            parameters: quaryParameters
        )
    }
}

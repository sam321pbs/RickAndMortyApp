//
//  DataSourceHelper.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 5/24/23.
//

import Foundation
import Alamofire

final class DataSourceHelper {
    
    private init() {}
    
    static func makeSingleRequest<T: Codable>(
        _ request: DataRequest,
        printLabel: String = ""
    ) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            request.responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    print("\(printLabel) - success response")
                    continuation.resume(with: .success(data))
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    print("\(printLabel) - Error response")
                    print("response code error - \(response.response?.statusCode)")
                    //                    print(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

//
//  DataSourceHelper.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 5/24/23.
//

import Foundation
import Alamofire
import RxSwift

final class DataSourceHelper {
    
    private init() {}
    
    static func makeSingleAlamoRequest<T: Codable>(
        _ request: DataRequest,
        printLabel: String = ""
    ) -> Single<T>  {
        let single = Single<T>.create{ (observer) -> Disposable in
//            request.responseJSON(completionHandler: { response in
//                print(response.response?.statusCode)
//                print(response)
//            })
//
            
            request.responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    print("\(printLabel) - success response")
                    observer(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                    print("\(printLabel) - Error response")
                    print("response code error - \(response.response?.statusCode)")
//                    print(error)
                    observer(.failure(error))
                }
            }
            return Disposables.create(with: { request.cancel() })
        }
        return single
    }
}

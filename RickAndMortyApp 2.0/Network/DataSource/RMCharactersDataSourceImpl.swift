//
//  RMGetAllCharactersDataSourceImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/23/23.
//

import Foundation
import RxSwift
import Alamofire

struct RMCharactersDataSourceImpl: RMCharactersDataSource {

    func getCharacterById(id: Int) -> Observable<RMCharacter> {
        let observable = Observable<RMCharacter>.create { (observer) -> Disposable in
            let request = RMApi.getCharactersByIdsDataRequest(ids: [id])
            request.responseDecodable(of: RMCharacter.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create(with: { request.cancel() })
        }
        return observable
    }
    
    func getCharactersByIds(ids: [Int]) -> Observable<[RMCharacter]> {
    
        let observable = Observable<[RMCharacter]>.create { (observer) -> Disposable in
            let request = RMApi.getCharactersByIdsDataRequest(ids: ids)
            if ids.count == 1 {
                request.responseDecodable(of: RMCharacter.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext([data])
                        observer.onCompleted()
                    case .failure(let error):
                        print(error)
                        observer.onError(error)
                    }
                }
            } else {
                request.responseDecodable(of: [RMCharacter].self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        print(error)
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create(with: { request.cancel() })
        }
        return observable
    }
    
    func getCharactersByPage(page: Int) -> Observable<RMGetCharactersResponse> {
        let observable = Observable<RMGetCharactersResponse>.create { (observer) -> Disposable in
            let request = RMApi.getCharactersByPageDataRequest(page: page)
            request.responseDecodable(of: RMGetCharactersResponse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create(with: { request.cancel() })
        }
        return observable
    }
    
    func getCharactersWithFilters(
        name: String?,
        status: RMCharacterStatus?,
        gender: RMCharacterGender?
    ) -> Observable<RMGetCharactersResponse> {
        let observable = Observable<RMGetCharactersResponse>.create { (observer) -> Disposable in
            let request = RMApi.getCharactersWithFiltersDataRequest(name: name, status: status, gender: gender)
            request.responseDecodable(of: RMGetCharactersResponse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create(with: { request.cancel() })
        }
        return observable
    }
}

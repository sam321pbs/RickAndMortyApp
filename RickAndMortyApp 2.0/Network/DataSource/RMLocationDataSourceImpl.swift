//
//  RMLocationDataSourceImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import RxSwift

final class RMLocationDataSourceImpl: RMLocationDataSource {
    
    func getLocationsByPage(page: Int) -> Observable<RMGetLocationsResponse> {
        let observable = Observable<RMGetLocationsResponse>.create { (observer) -> Disposable in
            let request = RMApi.getLocationsByPageDataRequest(page: page)
            request.responseDecodable(of: RMGetLocationsResponse.self) { response in
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
    
    func getLocationsByIds(ids: [Int]) -> Observable<[RMLocation]> {
        let observable = Observable<[RMLocation]>.create { (observer) -> Disposable in
            let request = RMApi.getLocationsByIdsDataRequest(ids: ids)
            request.responseDecodable(of: [RMLocation].self) { response in
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
    
    func getLocationById(id: Int) -> Observable<RMLocation> {
        let observable = Observable<RMLocation>.create { (observer) -> Disposable in
            let request = RMApi.getLocationsByIdsDataRequest(ids: [id])
            request.responseDecodable(of: RMLocation.self) { response in
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
    
    func getLocationsWithFilters(name: String?, type: String?) -> Observable<RMGetLocationsResponse> {
        let observable = Observable<RMGetLocationsResponse>.create { (observer) -> Disposable in
            let request = RMApi.getLocationsWithFiltersDataRequest(name: name, type: type)
            request.responseDecodable(of: RMGetLocationsResponse.self) { response in
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

//
//  RMEpisodesDataSourceImpl.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/26/23.
//

import RxSwift
import Alamofire

struct RMEpisodesDataSourceImpl: RMEpisodesDataSource {

    func getEpisodeById(id: Int) -> Observable<RMEpisode> {
        let observable = Observable<RMEpisode>.create { (observer) -> Disposable in
            let request = RMApi.getEpisodesByIdsDataRequest(ids: [id])
            request.responseDecodable(of: RMEpisode.self) { response in
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
    
    func getEpisodesByIds(ids: [Int]) -> Observable<[RMEpisode]> {
        let observable = Observable<[RMEpisode]>.create { (observer) -> Disposable in
            let request = RMApi.getEpisodesByIdsDataRequest(ids: ids)
            request.responseDecodable(of: [RMEpisode].self) { response in
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
        
    func getEpisodesByPage(page: Int) -> Observable<RMEpisodesResponse> {
        let observable = Observable<RMEpisodesResponse>.create { (observer) -> Disposable in
            let request = RMApi.getEpisodesByPageDataRequest(page: page)
            request.responseDecodable(of: RMEpisodesResponse.self) { response in
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
    
    func getEpisodesWithFilters(name: String?) -> Observable<RMEpisodesResponse> {
        let observable = Observable<RMEpisodesResponse>.create { (observer) -> Disposable in
            let request = RMApi.getEpisodesWithFiltersDataRequest(name: name)
            request.responseDecodable(of: RMEpisodesResponse.self) { response in
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

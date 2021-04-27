//
//  NetworkManager.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import Foundation
import Moya
import SwiftyJSON

class NetworkManager<T: Moya.TargetType> {
    
    private let provider: MoyaProvider<T>
    
    init(provider: MoyaProvider<T> = .init()) {
        self.provider = provider
    }
    
    func request(target: T, completion: @escaping (Result<JSON, Error>) -> ()) -> Moya.Cancellable {
        return provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    print(response, response.data)
                    completion(.success(try JSON(data: response.data)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

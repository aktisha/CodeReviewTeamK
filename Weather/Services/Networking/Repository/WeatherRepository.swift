//
//  WeatherRepository.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 16.04.2021.
//

import Foundation
import Moya
import SwiftyJSON

protocol WeatherRepository {
    @discardableResult
    func getWeather(long: Double, lat: Double, completion: @escaping (Result<JSON, Error>) -> ()) -> RequestCancellable
}

final class DefaultWeatherRepository: WeatherRepository {
    
    private let manager: NetworkManager<WeatherTarget>
    
    init(manager: NetworkManager<WeatherTarget>) {
        self.manager = manager
    }
    
    func getWeather(long: Double, lat: Double, completion: @escaping (Result<JSON, Error>) -> ()) -> RequestCancellable {
        let task = manager.request(target: .getWether([
            "lat": lat,
            "lon": long,
            "appid": Constants.APIKey.openWeatherMap,
            "exclude": "hourly,minutely,alerts"
        ]), completion: completion)
        
        return RepositoryTask(networkTask: task)
    }
}

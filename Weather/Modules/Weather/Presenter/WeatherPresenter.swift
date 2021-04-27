//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import Foundation
import SwiftyJSON

protocol WeatherPresenter: class {
    var view: WeatherView? { get set }
    func failedToFetchWeather(error: Error)
    func fetchedWeather(response: WeatherModel.Response)
    func fetching(_ loading: Bool)
    func requestLocation()
}


final class DefaultWeatherPresenter: WeatherPresenter {
    
    weak var view: WeatherView?
    
    func failedToFetchWeather(error: Error) {
        view?.showFailureAlert(error.localizedDescription)
    }
    
    func fetchedWeather(response: WeatherModel.Response) {
        var days: [Tempetature] = []
        for temp in response.json["daily"].array ?? [] {
            if let dt = temp["dt"].int,
               let avgTemp = temp["temp"]["day"].double {
                days.append(Tempetature(dateTime: Date(timeIntervalSince1970: TimeInterval(dt)),
                                        temp: avgTemp,
                                        minTemp: temp["temp"]["min"].double,
                                        maxTemp: temp["temp"]["max"].double))
            }
        }
        
        view?.fetchedWeather(viewModel: WeatherModel.ViewModel(days: days))
    }
    
    func fetching(_ loading: Bool) {
        view?.isLoading(loading)
    }
    
    func requestLocation() {
        view?.requestLocation()
    }
}

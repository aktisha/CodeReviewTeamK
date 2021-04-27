//
//  WeatherInteractor.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import Foundation
import Moya
import CoreLocation

protocol WeatherInteractor: class {
    var presenter: WeatherPresenter! { get set }
    func getWeather(request: WeatherModel.Request)
    func cancelGetWeather()
    func startLocationTracking()
}

final class DefaultWeatherInteractor: NSObject, WeatherInteractor {
    
    var presenter: WeatherPresenter!
    private var currentLocation: CLLocationCoordinate2D?
    private let repository: WeatherRepository
    private var getWeatherTask: RequestCancellable?
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
        return locationManager
    }()
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func getWeather(request: WeatherModel.Request) {
        cancelGetWeather()
        presenter.fetching(true)
        getWeatherTask = repository.getWeather(long: request.long, lat: request.lat) { [weak self] (result) in
            self?.presenter.fetching(false)
            switch result {
            case .success(let json):
                self?.presenter.fetchedWeather(response: WeatherModel.Response(json: json))
            case .failure(let error):
                self?.presenter.failedToFetchWeather(error: error)
            }
        }
    }
    
    func cancelGetWeather() {
        getWeatherTask?.cancel()
    }
    
    func startLocationTracking() {
        locationManager.startUpdatingLocation()
    }
    
}

extension DefaultWeatherInteractor: CLLocationManagerDelegate {
    
    func startLocationTrackingIfEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            startLocationTracking()
        } else {
            presenter.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = manager.location?.coordinate else {
            return
        }
        locationManager.stopUpdatingLocation()
        currentLocation = coordinate
        getWeather(request: WeatherModel.Request(lat: coordinate.latitude, long: coordinate.longitude))
    }
    
}

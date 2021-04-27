//
//  WeatherRouter.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import UIKit

protocol WeatherRouter: class {
    var view: (WeatherView & UIViewController)? { get set }
    func changeCity()
    func openLocationSettings()
}

final class DefaultWeatherRouter: WeatherRouter {
    
    weak var view: (WeatherView & UIViewController)?
    
    func changeCity() {
        let alert = UIAlertController(title: "Choose city", message: nil, preferredStyle: .actionSheet)
        
        City.allCases.forEach { (city) in
            alert.addAction(UIAlertAction(title: city.rawValue, style: .default, handler: { [weak self] _ in
                self?.view?.getWeather(for: city)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.view.tintColor = R.color.accentColor()
        
        view?.present(alert, animated: true)
    }
    
    func openLocationSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:])
    }
}

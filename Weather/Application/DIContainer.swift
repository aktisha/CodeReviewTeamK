//
//  DIContainer.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import UIKit
import Moya

final class DIContainer {
    
    static let shared = DIContainer()
    
    private init() {}
    
    func makeWeatherRepository() -> WeatherRepository {
        return DefaultWeatherRepository(manager: NetworkManager(provider: MoyaProvider()))
    }
    
    func makeWaetherView() -> UIViewController {
        let view = DefaultWeatherView()
        let router = DefaultWeatherRouter()
        let interactor = DefaultWeatherInteractor(repository: makeWeatherRepository())
        let presenter = DefaultWeatherPresenter()
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
    
}

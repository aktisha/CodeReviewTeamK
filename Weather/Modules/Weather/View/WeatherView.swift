//
//  WeatherView.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import UIKit

protocol WeatherView: class {
    var interactor: WeatherInteractor! { get set }
    var router: WeatherRouter! { get set }
    func showFailureAlert(_ message: String)
    func fetchedWeather(viewModel: WeatherModel.ViewModel)
    func isLoading(_ loading: Bool)
    func getWeather(for city: City)
    func requestLocation()
}

final class DefaultWeatherView: UIViewController {
    
    var interactor: WeatherInteractor!
    var router: WeatherRouter!
    private var viewModel: WeatherModel.ViewModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.reuseId)
        tableView.separatorInset = .zero
        tableView.separatorColor = R.color.border()
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var locationBarButton: UIBarButtonItem = UIBarButtonItem(title: "Location", style: .plain, target: self, action: #selector(currentLocation))
    
    private lazy var citiesBarButton: UIBarButtonItem = UIBarButtonItem(title: "Cities", style: .plain, target: self, action: #selector(changeCity))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.getWeather(request: WeatherModel.Request(lat: 33.441792, long: -94.037689))
        setupViews()
    }
    
    private func setupViews() {
        title = "Weather"
        view.backgroundColor = R.color.background()
        
        navigationItem.leftBarButtonItem = locationBarButton
        navigationItem.rightBarButtonItem = citiesBarButton
        
        [tableView].forEach(view.addSubview)
        
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        tableView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func currentLocation() {
        interactor.startLocationTracking()
    }
    
    @objc private func changeCity() {
        router.changeCity()
    }
    
    func requestLocation() {
        router.openLocationSettings()
    }
}

extension DefaultWeatherView: WeatherView {
    
    func showFailureAlert(_ message: String) {
        print("Failed to fetch data. Reason: ", message)
    }
    
    func fetchedWeather(viewModel: WeatherModel.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel = viewModel
            self?.tableView.reloadData()
        }
    }
    
    func isLoading(_ loading: Bool) {
        print("loading state: ", loading)
    }
    
    func getWeather(for city: City) {
        interactor.getWeather(request: WeatherModel.Request(lat: city.coordinates.0, long: city.coordinates.1))
    }
}

extension DefaultWeatherView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.days.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseId, for: indexPath) as? WeatherTableViewCell
        if let temperature = viewModel?.days[indexPath.row] {
            cell?.configure(temperature: temperature)
        }
        
        return cell ?? UITableViewCell()
    }
    
}

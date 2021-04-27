//
//  WeatherTarget.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 16.04.2021.
//

import Foundation
import Moya

enum WeatherTarget: HTTPTarget {
    case getWether([String: Any])
}

extension WeatherTarget {
    
    var path: String {
        switch self {
        case .getWether:
            return URLPath.oneCall
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWether:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getWether(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}

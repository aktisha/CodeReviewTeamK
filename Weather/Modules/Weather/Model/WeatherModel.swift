//
//  WeatherModel.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import Foundation
import SwiftyJSON

struct WeatherModel {
    
    struct Request {
        let lat: Double
        let long: Double
    }
    
    struct Response {
        let json: JSON
    }
    
    struct ViewModel {
        let days: [Tempetature]
    }
}

//
//  City.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import Foundation

enum City: String, CaseIterable {
    case almaty = "Almaty"
    case nursultan = "Nur-sultan"
    
    
    var coordinates: (Double, Double) {
        switch self {
        case .almaty:
            return (43.2220, 76.8512)
        case .nursultan:
            return (51.1605, 71.4704)
        }
    }
}

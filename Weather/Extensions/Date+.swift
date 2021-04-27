//
//  Date+.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import Foundation

extension Date {
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM"
        return dateFormatter.string(from: self)
    }
}

//
//  HTTPHeader.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 16.04.2021.
//

import Foundation

struct HTTPHeader {
    
    static var `default`: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
}

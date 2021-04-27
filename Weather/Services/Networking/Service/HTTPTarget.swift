//
//  HTTPTarget.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 16.04.2021.
//

import Foundation
import Moya

protocol HTTPTarget: TargetType { }

extension HTTPTarget {
    
    var environmentURL: String {
        return Constants.URL.baseUrl
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentURL) else { fatalError("baseURL could not be configured") }
        return url
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String : String]? {
        return HTTPHeader.default
    }
    
}

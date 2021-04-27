//
//  RepositoryTask.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import Foundation
import Moya

class RepositoryTask: RequestCancellable {
    var networkTask: Moya.Cancellable?
    
    func cancel() {
        networkTask?.cancel()
    }
    
    init(networkTask: Moya.Cancellable? = nil) {
        self.networkTask = networkTask
    }
}

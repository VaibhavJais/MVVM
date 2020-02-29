//
//  DIContainer.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

class SLContainer {

    // MARK: - Local data
    func makeLocalService() -> LocalService {
        let logger = DefaultNetworkErrorLogger()
        let localService = DefaultLocalService(logger: logger)

        return localService
    }

    // MARK: - Networking
    func makeNetworkConfigurable() -> ApiDataNetworkConfig {
        let url = URL(string: Constants.urlBase)
        return ApiDataNetworkConfig(baseURL: url!)
    }

    func makeNetworkService() -> NetworkService {
        return DefaultNetworkService(config: makeNetworkConfigurable())
    }

    // MARK: - Data Transfer Service
    func makeDataTransferErrorResolver() -> DataTransferErrorResolver {
        return DefaultDataTransferErrorResolver()
    }

    func makeDataTransferErrorLogger() -> DataTransferErrorLogger {
        return DefaultDataTransferErrorLogger()
    }
}

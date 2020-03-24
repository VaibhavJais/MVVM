//
//  SLExternalContainer.swift
//  MVVM
//
//  Created by Oscar Cardona on 17/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

class SLExternalContainer {

    // MARK: - Local data
    func makeLocalService() -> LocalService {
        let logger = DefaultNetworkErrorLogger()
        let bundle = Bundle.main

        return DefaultLocalService(logger: logger, bundle: bundle)
    }

    // MARK: - Networking
    func makeNetworkConfigurable() -> ApiDataNetworkConfig {
        let url = URL(string: "")
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

    func makeDataTransferService() -> DataTransferService {
        return DefaultDataTransferService(with: makeNetworkService(),
                                          errorResolver: makeDataTransferErrorResolver(),
                                          errorLogger: makeDataTransferErrorLogger())
    }
}


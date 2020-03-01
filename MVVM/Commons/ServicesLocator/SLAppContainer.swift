//
//  SLAppContainer.swift
//  MVVM
//
//  Created by Oscar Cardona on 01/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
//import SKRools
//
////MARK: - SLAppContainer
//final class SLAppContainer {
//
//    // MARK: - Properties
//    private (set) var container: Container
//
//    // MARK: - LifeCycle
//    init(container: Container = Container()) {
//        self.container = container
//        setup()
//    }
//
//    private func setup() {
//        container = Container()
//            .register(DataTransferService.self) { resolve in
//                return self.makeDataTransferService()
//        }
//    }
//
//    // MARK: - Networking
//    func makeNetworkConfigurable() -> ApiDataNetworkConfig {
//        let url = URL(string: Constants.urlBase)
//        return ApiDataNetworkConfig(baseURL: url!)
//    }
//
//    func makeNetworkService() -> NetworkService {
//        return DefaultNetworkService(config: makeNetworkConfigurable())
//    }
//
//    // MARK: - Data Transfer Service
//    func makeDataTransferErrorResolver() -> DataTransferErrorResolver {
//        return DefaultDataTransferErrorResolver()
//    }
//
//    func makeDataTransferErrorLogger() -> DataTransferErrorLogger {
//        return DefaultDataTransferErrorLogger()
//    }
//
//    func makeDataTransferService() -> DataTransferService {
//
//        return DefaultDataTransferService(with: makeNetworkService(),
//                                          errorResolver: makeDataTransferErrorResolver(),
//                                          errorLogger: makeDataTransferErrorLogger())
//    }
//}

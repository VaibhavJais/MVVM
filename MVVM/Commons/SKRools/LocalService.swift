//
//  LocalService.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

public enum LocalError: Error {
    case fileNotFound
    case cancelled
    case generic(Error)
}

public protocol LocalService {
    typealias CompletionHandler = (Result<Data?, LocalError>) -> Void

    func request(_ jsonName: String?,
                 completion: @escaping CompletionHandler)
}

// MARK: - Implementation
public final class DefaultLocalService: LocalService {
    private let logger: NetworkErrorLogger

    public init(logger: NetworkErrorLogger = DefaultNetworkErrorLogger()) {
        self.logger = logger
    }

    public func request(_ jsonName: String?, completion: @escaping CompletionHandler) {
        if let path = Bundle.main.path(forResource: jsonName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(.success(data))
            } catch let error {
                let localError = LocalError.generic(error)
                completion(.failure(localError))
            }
        }
    }
}

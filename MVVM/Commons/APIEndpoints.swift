//
//  APIEndpoints.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 13/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

// MARK: - Home Endpoints
struct APIEndpoints {
    static func homeList() -> Endpoint<HomeEntity> {
        return Endpoint(path: Constants.homeListEndpoint)
    }
}

// MARK: - Forces Enpoints
extension APIEndpoints {
    static func forcesList() -> Endpoint<ForcesListEntity> {
        return Endpoint(path: Constants.forcesListEndpoint)
    }

    static func forcesDetail(query: String) -> Endpoint<ForcesDetailEntity> {
        return Endpoint(path: Constants.forcesDetailEndpoint + query)
    }
}

// MARK: - Beers Enpoints

extension APIEndpoints {
    static func beersList() -> Endpoint<[BeerEntity]> {
        return Endpoint(path: Constants.beersListEndpoint)
    }
}


extension APIEndpoints {
    static func image(url: String) -> Endpoint<Data> {
        return Endpoint(path: url, responseDecoder: RawDataResponseDecoder())
    }
}

public class RawDataResponseDecoder: ResponseDecoder {
    public init() { }

    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}



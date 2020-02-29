//
//  APIEndpoints.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 13/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

// MARK: - Main Endpoints
struct APIEndpoints {
    static func mainList() -> Endpoint<MainListEntity> {
        return Endpoint(path: Constants.mainListEndpoint)
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

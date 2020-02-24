//
//  APIEndpoints.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 13/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import MVVMCommons

struct APIEndpoints {
    static func forcesList() -> Endpoint<ForcesListEntity> {
        return Endpoint(path: Constants.forcesListEndpoint)
    }

    static func forcesDetail(query: String) -> Endpoint<ForcesDetailEntity> {
        return Endpoint(path: Constants.forcesDetailEndpoint + query)
    }
}

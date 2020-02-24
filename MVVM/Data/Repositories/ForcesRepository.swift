//
//  ForcesRepository.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 13/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

struct ForcesDetailRequestValue {
    var queryString: String
}

final class DefaultForcesRepository {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultForcesRepository: ForcesRepository {
    func forcesList(completion: @escaping (Result<ForcesListEntity, Error>) -> Void) -> Cancellable? {
        let url = APIEndpoints.forcesList()
        let networkTask = self.dataTransferService.request(with: url, completion: completion)

        return RepositoryTask(networkTask: networkTask)
    }

    func forcesDetail(query: ForcesDetailRequestValue, completion: @escaping (Result<ForcesDetailEntity, Error>) -> Void) -> Cancellable? {
        let url = APIEndpoints.forcesDetail(query: query.queryString)
        let networkTask = self.dataTransferService.request(with: url, completion: completion)

        return RepositoryTask(networkTask: networkTask)
    }
}



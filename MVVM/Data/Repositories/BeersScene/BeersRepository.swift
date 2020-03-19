//
//  BeersRepository.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

final class DefaultBeersRepository {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultBeersRepository: BeersRepository {
    func beersList(completion: @escaping (Result<[BeerEntity], Error>) -> Void) -> Cancellable? {
        let url = APIEndpoints.beersList()
        let networkTask = self.dataTransferService.request(with: url, completion: completion)

        return RepositoryTask(networkTask: networkTask)
    }
}

//
//  HomeRepository.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

final class DefaultHomeRepository {
    private let localDataTransferService: LocalDataTransferService

       init(localDataTransferService: LocalDataTransferService) {
           self.localDataTransferService = localDataTransferService
       }
}

extension DefaultHomeRepository: HomeRepository {
    func homeItems(completion: @escaping (Result<HomeEntity, Error>) -> Void) {
        let url = APIEndpoints.homeList()
        localDataTransferService.localRequest(with: url, completion: completion)
    }
}

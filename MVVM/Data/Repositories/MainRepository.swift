//
//  MainRepository.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

final class DefaultMainRepository {
    private let localDataTransferService: LocalDataTransferService

       init(localDataTransferService: LocalDataTransferService) {
           self.localDataTransferService = localDataTransferService
       }
}

extension DefaultMainRepository: MainRepository {
    func mainList(completion: @escaping (Result<MainListEntity, Error>) -> Void) {
        let url = APIEndpoints.mainList()
        localDataTransferService.localRequest(with: url, completion: completion)
    }
}

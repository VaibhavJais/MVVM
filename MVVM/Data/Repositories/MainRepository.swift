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
    private let dataTransferService: DataTransferService

       init(dataTransferService: DataTransferService) {
           self.dataTransferService = dataTransferService
       }
}

extension DefaultMainRepository: MainRepository {
    func mainList(completion: @escaping (Result<MainListEntity, Error>) -> Void) -> Cancellable? {
        let url = APIEndpoints.mainList()
        let networkTask = self.dataTransferService.request(with: url, completion: completion)

        return RepositoryTask(networkTask: networkTask)
    }
}

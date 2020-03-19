//
//  ExternalRepository.swift
//  MVVM
//
//  Created by Oscar Cardona on 15/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

final class DefaultExternalRepository {

    private let dataTransferService: DataTransferService
    private let imageNotFoundData: Data?


    init(dataTransferService: DataTransferService,
    imageNotFoundData: Data?) {
        self.dataTransferService = dataTransferService
        self.imageNotFoundData = imageNotFoundData
    }
}

extension DefaultExternalRepository: ExternalRepository {
    func image(with imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {

        let endpoint = APIEndpoints.image(url: imageUrl)
        endpoint.isFullPath = true
        let networkTask = dataTransferService.request(with: endpoint) { [weak self] (response: Result<Data, Error>) in
            guard let strongSelf = self else { return }

            switch response {
            case .success(let data):
                completion(.success(data))
                return
            case .failure(let error):
                if case let DataTransferError.networkFailure(networkError) = error, networkError.isNotFoundError,
                    let imageNotFoundData = strongSelf.imageNotFoundData {
                    completion(.success(imageNotFoundData))
                    return
                }
                completion(.failure(error))
                return
            }
        }
        return RepositoryTask(networkTask: networkTask)
    }
}


//
//  ExternalRepository.swift
//  MVVM
//
//  Created by Oscar Cardona on 15/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools
import UIKit

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
        let networkTask = dataTransferService.request(with: endpoint) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let data):
                // TODO: Check in another way, if the data is an image or not, to be able to eliminate the UIKit import in this class
                if let _ = UIImage(data: data) {
                    completion(.success(data))
                } else {
                    if let imageNotFound = self?.imageNotFoundData {
                        completion(.success(imageNotFound))
                    } else {
                        // TODO: Implement custom error, "default image not found, not found xD)
                    }
                }

            case .failure(let error):
                if case let DataTransferError.networkFailure(networkError) = error, networkError.isNotFoundError,
                    let imageNotFoundData = strongSelf.imageNotFoundData {
                    completion(.success(imageNotFoundData))
                } else {
                    completion(.failure(error))
                }
            }
        }
        return RepositoryTask(networkTask: networkTask)
    }
}


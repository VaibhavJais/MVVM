//
//  RetrieveBeersListUseCase.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol BeersListUseCase {
    @discardableResult
    func execute(completion: @escaping (Result<[BeerEntity], Error>) -> Void) -> Cancellable?
    func image(with imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}

// MARK: - Execute
final class DefaultBeersListUseCase: BeersListUseCase {

    private let beersRepository: BeersRepository
    private let externalRepository: ExternalRepository

    init(beersRepository: BeersRepository,
         externalRepository: ExternalRepository) {
        self.beersRepository = beersRepository
        self.externalRepository = externalRepository
    }

    func execute(completion: @escaping (Result<[BeerEntity], Error>) -> Void) -> Cancellable? {
        return beersRepository.beersList(completion: completion)
    }
}

// MARK: - Images
extension DefaultBeersListUseCase {
    func image(with imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        return externalRepository.image(with: imageUrl, completion: completion)
    }
}

//
//  RetrieveMainListUseCase.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol MainListUseCase {
    @discardableResult
    func execute(completion: @escaping (Result<MainListEntity, Error>) -> Void ) -> Cancellable?
}

final class DefaultMainListUseCase: MainListUseCase {
    private let repository: MainRepository

    init(repository: MainRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<MainListEntity, Error>) -> Void) -> Cancellable? {
        return repository.mainList(completion: completion)
    }
}

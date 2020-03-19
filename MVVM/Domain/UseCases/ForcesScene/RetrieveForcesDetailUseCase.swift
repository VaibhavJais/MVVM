//
//  RetrieveForcesDetailUseCase.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 22/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol ForcesDetailUseCase {
    @discardableResult
    func execute(requestValue: ForcesDetailRequestValue, completion: @escaping (Result<ForcesDetailEntity, Error>) -> Void ) -> Cancellable?
}

final class DefaultForcesDetailUseCase: ForcesDetailUseCase {
    private let repository: ForcesRepository

    init(repository: ForcesRepository) {
        self.repository = repository
    }

    func execute(requestValue: ForcesDetailRequestValue, completion: @escaping (Result<ForcesDetailEntity, Error>) -> Void) -> Cancellable? {
        return repository.forcesDetail(query: requestValue, completion: completion)
    }
}

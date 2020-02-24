//
//  RetrieveForcesListUseCase.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 14/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import MVVMCommons

protocol ForcesListUseCase {
    @discardableResult
    func execute(completion: @escaping (Result<ForcesListEntity, Error>) -> Void) -> Cancellable?
}

final class DefaultForcesListUseCase: ForcesListUseCase {

    private let forcesListRepository: ForcesRepository

    init(forcesListRepository: ForcesRepository) {
        self.forcesListRepository = forcesListRepository
    }

    func execute(completion: @escaping (Result<ForcesListEntity, Error>) -> Void) -> Cancellable? {
        return forcesListRepository.forcesList(completion: { result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                completion(result)
            }
        })
    }
}

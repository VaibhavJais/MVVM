//
//  RetrieveHomeUseCase.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol HomeUseCase {
    func execute(completion: @escaping (Result<HomeEntity, Error>) -> Void )
}

final class DefaultHomeUseCase: HomeUseCase {
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<HomeEntity, Error>) -> Void) {
        repository.homeItems(completion: completion)
    }
}

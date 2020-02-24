//
//  ForcesRepositoryProtocol.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 14/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import MVVMCommons

protocol ForcesRepository {
    @discardableResult
    func forcesList(completion: @escaping (Result<ForcesListEntity, Error>) -> Void) -> Cancellable?
    @discardableResult
    func forcesDetail(query: ForcesDetailRequestValue, completion: @escaping (Result<ForcesDetailEntity, Error>) -> Void) -> Cancellable?
}

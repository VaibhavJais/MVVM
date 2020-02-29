//
//  MainRepositoryProtocol.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol MainRepository {
    @discardableResult
    func mainList(completion: @escaping (Result<MainListEntity, Error>) -> Void) -> Cancellable?
}

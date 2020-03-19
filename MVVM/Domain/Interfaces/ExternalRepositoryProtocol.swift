//
//  ExternalRepositoryProtocol.swift
//  MVVM
//
//  Created by Oscar Cardona on 15/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol ExternalRepository {
    func image(with imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}

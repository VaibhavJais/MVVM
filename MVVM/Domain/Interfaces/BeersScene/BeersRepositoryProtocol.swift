//
//  BeersRepositoryProtocol.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol BeersRepository {
    func beersList(completion: @escaping (Result<[BeerEntity], Error>) -> Void) -> Cancellable?
}

//
//  BoilVolume+Decodable.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension BoilVolume: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value
        case unit
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try? container.decodeIfPresent(Int.self, forKey: .value)
        self.unit = try? container.decodeIfPresent(String.self, forKey: .unit)
    }
}

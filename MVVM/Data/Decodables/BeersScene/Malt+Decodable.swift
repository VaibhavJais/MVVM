//
//  Malt+Decodable.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension Malt: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case amount
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.amount = try? container.decodeIfPresent(Amount.self, forKey: .amount)
    }
}

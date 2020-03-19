//
//  Hops+Decodable.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension Hops: Decodable {
    private enum CodingKeys: String, CodingKey {
        case add
        case attribute
        case name
        case amount
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.amount = try? container.decodeIfPresent(Amount.self, forKey: .amount)
        self.add = try? container.decodeIfPresent(String.self, forKey: .add)
        self.attribute = try? container.decodeIfPresent(String.self, forKey: .attribute)
    }
}

//
//  Ingredients+Decodable.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension Ingredients: Decodable {
    private enum CondigKeys: String, CodingKey {
        case hops
        case malt
        case yeast
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CondigKeys.self)
        self.hops = try? container.decodeIfPresent([Hops].self, forKey: .hops)
        self.malt = try? container.decodeIfPresent([Malt].self, forKey: .malt)
        self.yeast = try? container.decodeIfPresent(String.self, forKey: .yeast)
    }
}




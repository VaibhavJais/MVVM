//
//  ForcesList+Decodable.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 14/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension ForcesListEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case forces
    }

    public init(from decoder: Decoder) throws {
        let data = try decoder.singleValueContainer()
        self.forces = try data.decode([ForcesListItemEntity].self)
    }
}

extension ForcesListItemEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case forceId = "id"
        case forceName = "name"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.forcesId = try container.decodeIfPresent(String.self, forKey: .forceId)
        self.forcesName = try container.decodeIfPresent(String.self, forKey: .forceName)
    }
}

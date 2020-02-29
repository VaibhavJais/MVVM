//
//  MainList+Decodable.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension MainListEntity: Decodable {

    private enum CondigKeys: String, CodingKey {
        case items
    }

    public init(from decoder: Decoder) throws {
        let data = try decoder.singleValueContainer()
        self.items = try data.decode([MainItemEntity].self)
    }
}

extension MainItemEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageUrl
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
    }
}

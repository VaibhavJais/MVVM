//
//  Home+Decodable.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension HomeEntity: Decodable {

    private enum CodingKeys: String, CodingKey {
        case items
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try (container.decodeIfPresent([HomeItemEntity].self, forKey: .items) ?? [])
    }
}

extension HomeItemEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageName
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.imageName = try container.decodeIfPresent(String.self, forKey: .imageName)
    }
}

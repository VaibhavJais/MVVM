//
//  ForcesDetailEngagementEntity+Decodable.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 23/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension ForcesDetailEngagementEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case url
        case type
        case description
        case title
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: CodingKeys.url)
        self.description = try container.decodeIfPresent(String.self, forKey: CodingKeys.description)
        self.title = try container.decodeIfPresent(String.self, forKey: CodingKeys.title)
        self.type = try container.decodeIfPresent(String.self, forKey: CodingKeys.type)
    }

}

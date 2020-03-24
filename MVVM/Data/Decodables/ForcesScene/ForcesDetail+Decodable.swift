//
//  ForcesDetail+Decodable.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 22/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension ForcesDetailEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case description
        case url
        case engagementMethods = "engagement_methods"
        case telephone
        case identifier = "id"
        case name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.telephone = try container.decodeIfPresent(String.self, forKey: .telephone)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.identifier = try container.decodeIfPresent(String.self, forKey: .identifier)
        self.engagementMethods = try (container.decodeIfPresent([ForcesDetailEngagementEntity].self, forKey: .engagementMethods) ?? [])
    }
}

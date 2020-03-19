//
//  Fermentation+Decodable.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension Fermentatiom: Decodable {
    private enum CodingKeys: String, CodingKey {
        case temp
    }

    public init(from decoder: Decoder) throws {
        let conteiner = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try? conteiner.decodeIfPresent(Temp.self, forKey: .temp)
    }
}

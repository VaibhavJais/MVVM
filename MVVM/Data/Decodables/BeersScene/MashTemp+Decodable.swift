//
//  MashTemp+Decodable.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension MashTemp: Decodable {
    private enum CodingKeys: String, CodingKey {
        case temp
        case duration
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try? container.decodeIfPresent(Temp.self, forKey: .temp)
        self.duration = try? container.decodeIfPresent(Int.self, forKey: .duration)
    }
}

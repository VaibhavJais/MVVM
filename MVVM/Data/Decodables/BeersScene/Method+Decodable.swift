//
//  Method+Decodable.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension Method: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation
        case twist
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mashTemp = try? container.decodeIfPresent([MashTemp].self, forKey: .mashTemp)
        self.fermentation = try? container.decodeIfPresent(Fermentatiom.self, forKey: .fermentation)
        self.twist = try? container.decodeIfPresent(String.self, forKey: .twist)
    }
}



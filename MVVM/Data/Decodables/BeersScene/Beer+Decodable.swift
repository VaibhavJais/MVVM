//
//  Beer+Decodable.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

extension BeerEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case identifier
        case name
        case tagline
        case firstBrewed = "first_brewed"
        case description
        case imageUrl = "image_url"
        case abv
        case ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc
        case srm
        case ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method
        case ingredients
        case foodPairing
        case brewersTips
        case contributedBy
    }


    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try? container.decodeIfPresent(String.self, forKey: .identifier)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.tagline = try? container.decodeIfPresent(String.self, forKey: .tagline)
        self.firstBrewed = try? container.decodeIfPresent(String.self, forKey: .firstBrewed)
        self.description = try? container.decodeIfPresent(String.self, forKey: .description)
        self.imageUrl = try? container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.abv = try? container.decodeIfPresent(Double.self, forKey: .abv)
        self.ibu = try? container.decodeIfPresent(Double.self, forKey: .ibu)
        self.targetFg = try? container.decodeIfPresent(Float.self, forKey: .targetFg)
        self.targetOg = try? container.decodeIfPresent(Float.self, forKey: .targetOg)
        self.ebc = try? container.decodeIfPresent(Float.self, forKey: .ebc)
        self.srm = try? container.decodeIfPresent(Float.self, forKey: .srm)
        self.ph = try? container.decodeIfPresent(Float.self, forKey: .ph)
        self.attenuationLevel = try container.decodeIfPresent(Float.self, forKey: .attenuationLevel)
        self.volume = try? container.decodeIfPresent(Volume.self, forKey: .volume)
        self.boilVolume = try? container.decodeIfPresent(BoilVolume.self, forKey: .boilVolume)
        self.method = try? container.decodeIfPresent(BeerMethod.self, forKey: .method)
        self.ingredients = try? container.decodeIfPresent(Ingredients.self, forKey: .ingredients)
        self.foodPairing = try? container.decodeIfPresent([String].self, forKey: .foodPairing)
        self.brewersTips = try? container.decodeIfPresent(String.self, forKey: .brewersTips)
        self.contributedBy = try? container.decodeIfPresent(String.self, forKey: .contributedBy)
    }
}

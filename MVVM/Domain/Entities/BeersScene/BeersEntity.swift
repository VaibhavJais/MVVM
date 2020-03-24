//
//  BeersEntity.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

// MARK: - Beer List Entity
struct BeersListEntity {
    let Beers: [BeerEntity]?
}

// MARK: - Beer Entity
struct BeerEntity {
    let identifier: String?
    let name: String?
    let tagline: String?
    let firstBrewed: String?
    let description: String?
    let imageUrl: String?
    let abv: Double?
    let ibu: Double?
    let targetFg: Float?
    let targetOg: Float?
    let ebc: Float?
    let srm: Float?
    let ph: Float?
    let attenuationLevel: Float?
    let volume: Volume?
    let boilVolume: BoilVolume?
    let method: BeerMethod?
    let ingredients: Ingredients?
    let foodPairing: [String]?
    let brewersTips: String?
    let contributedBy: String?

}

struct Volume {
    let value: Int?
    let unit: String?
}

struct BoilVolume {
    let value: Int?
    let unit: String?
}

struct BeerMethod {
    let mashTemp: [MashTemp]?
    let fermentation: Fermentatiom?
    let twist: String?
}

struct MashTemp {
    let temp: Temp?
    let duration: Int?
}

struct Temp {
    let value: Int?
    let unit: String?
}

struct Fermentatiom {
    let temp: Temp?
}

struct Ingredients {
    let malt: [Malt]?
    let hops: [Hops]?
    let yeast: String?
}

struct Malt {
    let name: String?
    let amount: Amount?
}

struct Amount {
    let value: Double?
    let unit: String?
}

struct Hops {
    let name: String?
    let amount: Amount?
    let add: String?
    let attribute: String?
}

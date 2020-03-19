//
//  BeersListModel.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol BeersListModel {
    var items: [BeerModel]? { get set }
}

struct DefaultBeersListModel: BeersListModel {
    var items: [BeerModel]?
    init(beers: [BeerModel]?) {
        self.items = beers
    }
}

protocol BeerModel {
    var name: String? { get }
    var tagline: String? { get }
    var imageUrl: String? { get }
    var abv: String? { get }
    var ebc: String? { get }
    var ibu: String? { get }
    var image: Box<Data?> { get set }
}

struct DefaultBeerModel: BeerModel {
    let name: String?
    let imageUrl: String?
    let tagline: String?
    let abv: String?
    let ebc: String?
    let ibu: String?
    var image: Box<Data?>

    init(beer: BeerEntity) {
        self.name = beer.name
        self.imageUrl = beer.imageUrl
        self.tagline = beer.tagline
        self.image = Box(nil)
        self.abv = "\(beer.abv ?? 0.0)%"
        self.ibu = "\(beer.ibu ?? 0.0)%"
        self.ebc = String(format: "%.0f", beer.ebc ?? 0)
    }
}


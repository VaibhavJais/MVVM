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
    var image: Box<Data?> { get set }
}

struct DefaultBeerModel: BeerModel {
    let name: String?
    let imageUrl: String?
    let tagline: String?
    var image: Box<Data?>

    init(beer: BeerEntity) {
        self.name = beer.name
        self.imageUrl = beer.imageUrl
        self.tagline = beer.tagline
        self.image = Box(nil)
    }
}


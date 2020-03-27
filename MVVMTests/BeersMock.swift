//
//  BeersMock.swift
//  MVVMTests
//
//  Created by Oscar Cardona on 27/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import XCTest
@testable import MVVM

class BeersMock: XCTestCase {

    static func makeBeerListEntityMock() -> [BeerEntity] {
        let volume =  Volume(value: 1, unit: "kg")
        let boil = BoilVolume(value: 2, unit: "kg")
        let temp = Temp(value: 1, unit: "c")
        let mashTemp = MashTemp(temp: temp, duration: 3)
        let fermentation = Fermentatiom(temp: temp)
        let beerMethod = BeerMethod(mashTemp: [mashTemp], fermentation: fermentation, twist: "twist")
        let amount = Amount(value: 2.3, unit: "kg")
        let malt = Malt(name: "malt name", amount: amount)
        let hops = Hops(name: "hop name", amount: amount, add: "no", attribute: "attribu")
        let ingredients = Ingredients(malt: [malt], hops: [hops], yeast: "yeast")
        let beer = BeerEntity(identifier: "123",
                              name: "Beer Test",
                              tagline: "Tag line",
                              firstBrewed: "21/2209",
                              description: "beer description",
                              imageUrl: "http://fake.url",
                              abv: 21.0,
                              ibu: 12.9,
                              targetFg: 10,
                              targetOg: 20,
                              ebc: 2.3,
                              srm: 1.2,
                              ph: 4.3,
                              attenuationLevel: 4.4,
                              volume: volume,
                              boilVolume: boil,
                              method: beerMethod,
                              ingredients: ingredients,
                              foodPairing: ["chees"],
                              brewersTips: "tips",
                              contributedBy: "contr")
        return [beer]
    }


    static func makeBeersListJsonMock() -> Data {
        return Data("""
        {
        "id": 192,
        "name": "Punk IPA 2007 - 2010",
        "tagline": "Post Modern Classic. Spiky. Tropical. Hoppy.",
        "first_brewed": "04/2007",
        "description": "Our flagship beer that kick started the craft beer revolution. This is James and Martin's original take on an American IPA, subverted with punchy New Zealand hops. Layered with new world hops to create an all-out riot of grapefruit, pineapple and lychee before a spiky, mouth-puckering bitter finish.",
        "image_url": "https://images.punkapi.com/v2/192.png",
        "abv": 6.0,
        "ibu": 60.0,
        "target_fg": 1010.0,
        "target_og": 1056.0,
        "ebc": 17.0,
        "srm": 8.5,
        "ph": 4.4,
        "attenuation_level": 82.14,
        "volume": {
          "value": 20,
          "unit": "liters"
        },
        "boil_volume": {
          "value": 25,
          "unit": "liters"
        },
        "method": {
          "mash_temp": [
            {
              "temp": {
                "value": 65,
                "unit": "celsius"
              },
              "duration": 75
            }
          ],
          "fermentation": {
            "temp": {
              "value": 19.0,
              "unit": "celsius"
            }
          },
          "twist": null
        },
        "ingredients": {
          "malt": [
            {
              "name": "Extra Pale",
              "amount": {
                "value": 5.3,
                "unit": "kilograms"
              }
            }
          ],
          "hops": [
            {
              "name": "Ahtanum",
              "amount": {
                "value": 17.5,
                "unit": "grams"
               },
               "add": "start",
               "attribute": "bitter"
             },
             {
               "name": "Chinook",
               "amount": {
                 "value": 15,
                 "unit": "grams"
               },
               "add": "start",
               "attribute": "bitter"
             },
          ],
          "yeast": "Wyeast 1056 - American Ale™"
        },
        "food_pairing": [
          "Spicy carne asada with a pico de gallo sauce",
          "Shredded chicken tacos with a mango chilli lime salsa",
          "Cheesecake with a passion fruit swirl sauce"
        ],
        "brewers_tips": "While it may surprise you, this version of Punk IPA isn't dry hopped but still packs a punch! To make the best of the aroma hops make sure they are fully submerged and add them just before knock out for an intense hop hit.",
        "contributed_by": "Sam Mason <samjbmason>"
      }
    """.utf8)
    }
}

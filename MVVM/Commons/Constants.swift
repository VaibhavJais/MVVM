//
//  Constants.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 23/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

public enum Constants {
    static let urlBase = "https://data.police.uk/api/"
    static let beersUrlBase = "https://api.punkapi.com/v2/"

    // MARK: - Endpoints
    static let forcesListEndpoint = "forces"
    static let forcesDetailEndpoint = "forces/"
    static let homeListEndpoint = "HomeLocalData"
    static let beersListEndpoint = "beers"

    // MARK: - Storyboard Identifier
    static let homeStoryboard = "HomeStoryboard"
    static let forcesListStoryboard = "Main"
    static let forcesDetailStoryboard = "ForcesDetailStoryboard"
    static let beersListStoryboard = "BeerListStoryboard"

    // TODO: Move this constants to Beer scene
    // MARK: - Fonts
    static let fontTitle = "Verdana-bold"
    static let fontDescription = "Verdana"

    // MARK: - Default Images
    static let defaultImage = "beerGreen"
    static let notFoundImage = "imageError"
}

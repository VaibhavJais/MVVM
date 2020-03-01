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

    // MARK: - Endpoints
    static let forcesListEndpoint = "forces"
    static let forcesDetailEndpoint = "forces/"
    static let homeListEndpoint = "HomeLocalData"

    // MARK: - Storyboard Identifier
    static let homeStoryboard = "HomeStoryboard"
    static let forcesListStoryboard = "Main"
    static let forcesDetailStoryboard = "ForcesDetailStoryboard"
}

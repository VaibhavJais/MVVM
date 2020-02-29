//
//  LocalConfigurable.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

public protocol LocalConfigurable {
    var jsonName: String { get }
}

public struct LocalNetworkConfig: LocalConfigurable {
    public let jsonName: String

    public init(jsonName: String = "") {
        self.jsonName = jsonName
    }
}

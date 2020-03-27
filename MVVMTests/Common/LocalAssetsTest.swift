//
//  LocalAssetsTest.swift
//  MVVMTests
//
//  Created by Oscar Cardona on 27/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import XCTest
@testable import MVVM

class LocalAssetsTest: XCTestCase {

    func testDefaultImage() {
        let message = "Default Image Not Found"
        assert(UIImage(named: Constants.defaultImage) != nil, message)
    }

    func testDefaultErrorImage() {
        let message = "Default Error Image Not Found"
        assert(UIImage(named: Constants.notFoundImage) != nil, message)
    }
}

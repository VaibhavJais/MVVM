//
//  ForcesMock.swift
//  MVVMTests
//
//  Created by Oscar Cardona on 28/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import XCTest
@testable import MVVM
@testable import SKRools

class ForcesMock: XCTestCase {

    static func makeForcesListEntityMock() -> ForcesListEntity {
        let force = ForcesListItemEntity(forcesId: "1", forcesName: "name")
        let forcesList = ForcesListEntity(forces: [force])

           return forcesList
       }

}

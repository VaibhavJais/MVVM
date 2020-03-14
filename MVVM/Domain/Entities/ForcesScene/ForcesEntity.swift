//
//  ForcesEntity.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 14/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

struct ForcesListEntity {
    let forces: [ForcesListItemEntity]
}

struct ForcesListItemEntity {
    let forcesId: String?
    let forcesName: String?
}

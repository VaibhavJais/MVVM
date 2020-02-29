//
//  MainListEntity.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

struct MainListEntity {
    var items: [MainItemEntity]
}

struct MainItemEntity {
    var title: String?
    var description: String?
    var imageUrl: String?
}

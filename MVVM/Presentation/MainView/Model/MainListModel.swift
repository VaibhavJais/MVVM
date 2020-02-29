//
//  MainListModel.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

// MARK: - MainListModel
protocol MainListModel: MainListModelOutput {}

// MARK: - MainListModelOutput Protocol
protocol MainListModelOutput {
    var viewTitle: String? { get }
    var items: [MainListItemModel]? { get }
}

// MARK: - DefaultMainListModel
struct DefaultMainListModel: MainListModel {
    var viewTitle: String?
    var items: [MainListItemModel]?

    init(mainListEntity: MainListEntity) {
        self.items = mainListEntity.items.map { DefaultMainListItemModel(mainListItemEntity: $0) }
    }
}

// MARK: - MainListItemModel
protocol MainListItemModel: MainListItemModelOutput {}

// MARK: - MainListItemModelOutput Protocol
protocol MainListItemModelOutput {
    var title: String? { get }
    var description: String? { get }
    var imageUrl: String? { get }
}

// MARK: - DefaultMainListItemModel
struct DefaultMainListItemModel: MainListItemModel {
    var title: String?
    var description: String?
    var imageUrl: String?

    init(mainListItemEntity: MainItemEntity) {
        self.title = mainListItemEntity.title
        self.description = mainListItemEntity.description
        self.imageUrl = mainListItemEntity.imageUrl
    }
}

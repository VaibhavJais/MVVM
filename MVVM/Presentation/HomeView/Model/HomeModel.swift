//
//  HomeModel.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

// MARK: - HomeModel
protocol HomeModel: HomeModelOutput {}

// MARK: - HomeModelOutput Protocol
protocol HomeModelOutput {
    var viewTitle: String? { get }
    var items: [HomeItemModel]? { get }
}

// MARK: - DefaultHomeModel
struct DefaultHomeModel: HomeModel {
    var viewTitle: String?
    var items: [HomeItemModel]?

    init(homeEntity: HomeEntity) {
        self.items = homeEntity.items.map { DefaultHomeItemModel(homeItemEntity: $0) }
    }
}

// MARK: - HomeItemModel
protocol HomeItemModel: HomeItemModelOutput {}

// MARK: - HomeItemModelOutput Protocol
protocol HomeItemModelOutput {
    var id: String? { get }
    var title: String? { get }
    var description: String? { get }
    var imageName: String? { get }
}

// MARK: - DefaultHomeItemModel
struct DefaultHomeItemModel: HomeItemModel {
    var id: String?
    var title: String?
    var description: String?
    var imageName: String?

    init(homeItemEntity: HomeItemEntity) {
        self.id = homeItemEntity.id
        self.title = homeItemEntity.title
        self.description = homeItemEntity.description
        self.imageName = homeItemEntity.imageName
    }
}

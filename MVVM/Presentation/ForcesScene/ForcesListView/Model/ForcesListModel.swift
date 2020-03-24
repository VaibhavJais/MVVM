//
//  ForcesListItemViewModel.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 14/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

// MARK: - ForcesListModel
protocol ForcesListModel: ForcesListModelOutput {}

// MARK: - ForcesListModelOutput
protocol ForcesListModelOutput {
    var forcesId: String? { get }
    var forcesName: String? { get }
}

// MARK: - DefaultForcesListModel
struct DefaultForcesListModel: ForcesListModel {
    let forcesId: String?
    let forcesName: String?

    init(forces: ForcesListItemEntity) {
        self.forcesId = forces.forcesId
        self.forcesName = forces.forcesName
    }
}

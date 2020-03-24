//
//  ForcesDetailEngagementModel.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 23/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

//MARK: - ForcesDetailEngagementModel
struct ForcesDetailEngagementModel {
    var url: String?
    var type: String?
    var description: String?
    var title: String?

    init(forcesEngagement: ForcesDetailEngagementEntity) {
        self.url = forcesEngagement.url
        self.type = forcesEngagement.type
        self.description = forcesEngagement.description
        self.title = forcesEngagement.title
    }
}

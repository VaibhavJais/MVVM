//
//  ForcesDetailItemViewModel.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 22/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation

//MARK: - ForcesDetailModel
protocol ForcesDetailModel: ForcesDetailModelOutput {}

//MARK: - ForcesDetailModelOutput
protocol ForcesDetailModelOutput {
    var description: String? { get }
    var url: String?  { get }
    var engagementMethods: [ForcesDetailEngagementModel]? { get }
    var telephone: String?  { get }
    var name: String?  { get }
}

//MARK: - DefaultForcesDetailModel
struct DefaultForcesDetailModel: ForcesDetailModel {
    var description: String?
    var url: String?
    var engagementMethods: [ForcesDetailEngagementModel]?
    var telephone: String?
    var name: String?

    init(forcesDetail: ForcesDetailEntity) {
        self.description = forcesDetail.description
        self.url = forcesDetail.url
        self.engagementMethods = forcesDetail.engagementMethods.map { ForcesDetailEngagementModel(forcesEngagement: $0 )}
        self.telephone = forcesDetail.telephone
        self.name = forcesDetail.name
    }
}

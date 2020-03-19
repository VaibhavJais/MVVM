//
//  BeersCoordinator.swift
//  MVVM
//
//  Created by Oscar Cardona on 15/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import UIKit
import SKRools

final class BeersCoordinator: Coordinator {
    weak var parentCoordinator: HomeCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let container: SLBeersContainer?

    init(navigationController: UINavigationController,
         container: SLBeersContainer = DefaultSLBeersContainer()) {
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
         guard let vc = container?.beersListView() else { return }
//         vc.forcesDetail = { [weak self] identifier in
//             self?.forcesDetail(identifier: identifier)
//         }
//         vc.coordinator = self
         navigationController.pushViewController(vc, animated: true)
     }
}

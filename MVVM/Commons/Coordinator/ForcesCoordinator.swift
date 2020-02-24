//
//  MainCoordinator.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 21/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit
import SKRools

class ForcesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let containerForces: DIForcesContainer = DIForcesContainer()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let vc = containerForces.container?.resolve(ForcesListViewController.self) else {
            // TODO error
            return
        }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func forcesDetail(with identifier: String) {
        let vc = containerForces.container?.resolve(ForcesDetailViewController.self)
        guard let viewController = vc else {
            //TODO Throws error
            return
        }
        viewController.coordinator = self
        viewController.viewModel?.updateView(forcesId: identifier)
        navigationController.pushViewController(viewController, animated: true)
    }
}

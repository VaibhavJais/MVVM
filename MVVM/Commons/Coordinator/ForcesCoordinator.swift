//
//  ForcesCoordinator.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 21/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit
import SKRools

protocol ForcesCoordinatorProtocol {
    func forcesList()
}

final class ForcesCoordinator: Coordinator {
    weak var parentCoordinator: HomeCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var container: SLForcesContainer?

    init(navigationController: UINavigationController,
         container: SLForcesContainer = SLForcesContainer()) {
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
        guard let vc = container?.container?.resolve(ForcesListViewController.self) else {
            // TODO error
            return
        }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func forcesDetail(with identifier: String) {
        let vc = container?.container?.resolve(ForcesDetailViewController.self)
        guard let viewController = vc else {
            //TODO Throws error
            return
        }
        viewController.coordinator = self
        viewController.viewModel?.updateView(forcesId: identifier)
        navigationController.pushViewController(viewController, animated: true)
    }
}

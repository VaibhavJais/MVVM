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
    func showForcesDetail()
}

final class ForcesCoordinator: Coordinator {
    weak var parentCoordinator: HomeCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let container: SLForcesContainer?

    init(navigationController: UINavigationController,
         container: SLForcesContainer = DefaultSLForcesContainer()) {
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
        guard let vc = container?.forcesListView() else { return }
        vc.forcesDetail = { [weak self] identifier in
            self?.forcesDetail(identifier: identifier)
        }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func forcesDetail(identifier: String) {
        guard let viewController = container?.forcesDetailView() else { return }
        viewController.coordinator = self
        viewController.viewModel?.updateView(forcesId: identifier)
        navigationController.pushViewController(viewController, animated: true)
    }
}

//
//  MainListCoordinator.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import UIKit
import SKRools

class MainListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let container: DIMainListContainer = DIMainListContainer()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let vc = container.container?.resolve(MainListViewController.self) else {
            // TODO error
            return
        }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

}


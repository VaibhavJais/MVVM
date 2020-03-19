//
//  HomeCoordinator.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import UIKit
import SKRools

class HomeCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let container: SLHomeContainer? = DefaultSLHomeContainer()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let vc = container?.homeView() else { return }
        vc.forcesList = { [weak self] in
            self?.forcesSubscription()
        }
        vc.beersList = { [weak self] in
            self?.beersSubscription()
        }
        navigationController.delegate = self
        navigationController.pushViewController(vc, animated: false)
    }

    func forcesSubscription() {
        let child = ForcesCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }

    func beersSubscription() {
          let child = BeersCoordinator(navigationController: navigationController)
          child.parentCoordinator = self
          childCoordinators.append(child)
          child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() {
                if coordinator === child {
                    coordinator.childCoordinators.removeAll()
                    childCoordinators.remove(at: index)
                    break
                }
        }
    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if  navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let forcesListViewController = fromViewController as? ForcesListViewController {
            childDidFinish(forcesListViewController.coordinator)
            forcesListViewController.viewModel = nil
            forcesListViewController.coordinator = nil
        }
        if let beersListViewController = fromViewController as? BeersListViewController {
            childDidFinish(beersListViewController.coordinator)
            beersListViewController.viewModel = nil
            beersListViewController.coordinator = nil
        }
    }
}


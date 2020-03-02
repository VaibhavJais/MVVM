//
//  SLHomeContainer.swift
//  MVVM
//
//  Created by Oscar Cardona on 01/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol SLHomeContainer {
    func homeView() -> HomeViewController
}

final class DefaultSLHomeContainer: SLContainer, SLHomeContainer {
    func homeView() -> HomeViewController {
        return makeHomeView()
    }
}

private extension DefaultSLHomeContainer {
    // MARK: - Common
    private func makeLocalDataTransferService() -> LocalDataTransferService {
        return DefaultLocalDataTransferService(with: makeLocalService())
    }

    // MARK: - Home View Depedencies
    private func makeHomeRepository() -> HomeRepository {
        return DefaultHomeRepository(localDataTransferService: makeLocalDataTransferService())
    }

    private func makeHomeUseCase() -> HomeUseCase {
        return DefaultHomeUseCase(repository: makeHomeRepository())
    }

    private func makeHomeViewModel() -> HomeViewModel {
        return DefaultHomeViewModel(homeUseCase: makeHomeUseCase())
    }

    // MARK: - Home View
    private func makeHomeView() -> HomeViewController {
        let viewController = HomeViewController.instantiate(storyboardName: Constants.homeStoryboard)
        viewController.viewModel = makeHomeViewModel()

        return viewController
    }
}

//
//  SLHomeContainer.swift
//  MVVM
//
//  Created by Oscar Cardona on 01/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

final class SLHomeContainer: SLContainer {

    // MARK: - Properties
    private (set) var container: Container?

    // MARK: - LifeCycle
    override init() {
        super.init()
        setup()
    }

    private func setup() {
        container = Container()
            .register(HomeViewController.self) { resolve in
                return self.makeHomeView()
        }
    }
}

private extension SLHomeContainer {
    // MARK: - Common
    private func makeLocalDataTransferService() -> LocalDataTransferService {
        return DefaultLocalDataTransferService(with: makeLocalService())
    }

    // MARK: - Forces List
    private func makeHomeRepository() -> HomeRepository {
        return DefaultHomeRepository(localDataTransferService: makeLocalDataTransferService())
    }

    private func makeHomeUseCase() -> HomeUseCase {
        return DefaultHomeUseCase(repository: makeHomeRepository())
    }

    private func makeHomeViewModel() -> HomeViewModel {
        return DefaultHomeViewModel(homeUseCase: makeHomeUseCase())
    }

    private func makeHomeView() -> HomeViewController {
        let viewController = HomeViewController.instantiate(storyboardName: Constants.homeStoryboard)
        viewController.viewModel = makeHomeViewModel()

        return viewController
    }
}


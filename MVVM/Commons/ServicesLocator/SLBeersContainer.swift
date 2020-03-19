//
//  SLBeersContainer.swift
//  MVVM
//
//  Created by Oscar Cardona on 15/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol SLBeersContainer {
    func beersListView() -> BeersListViewController
}

final class DefaultSLBeersContainer: SLBeersBaseContainer, SLBeersContainer {
    func beersListView() -> BeersListViewController {
        return makeBeersListView()
    }
}

private extension DefaultSLBeersContainer {

    // MARK: - Beers List dependencies
    private func makeBeersListRepository() -> BeersRepository {
        return DefaultBeersRepository(dataTransferService: makeDataTransferService())
    }

    private func makeExternalRepository() -> ExternalRepository {
        return DefaultExternalRepository(dataTransferService: makeDataTransferService(),
                                         imageNotFoundData: nil)
    }

    private func makeBeersListUseCase() -> BeersListUseCase {
        return DefaultBeersListUseCase(beersRepository: makeBeersListRepository(),
                                       externalRepository: makeExternalRepository())
    }

    private func makeBeersListViewModel() -> BeersListViewModel {
        return DefaultBeersListViewModel(beersListUseCase: makeBeersListUseCase())
    }

    // MARK: - Forces List View
    private func makeBeersListView() -> BeersListViewController {
        let viewController = BeersListViewController.instantiate(storyboardName: Constants.beersListStoryboard)
        viewController.viewModel = makeBeersListViewModel()

        return viewController
    }
}

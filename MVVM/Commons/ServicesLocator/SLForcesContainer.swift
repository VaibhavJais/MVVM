//
//  SLForcesContainer.swift
//  MVVM
//
//  Created by Oscar Cardona on 01/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

protocol SLForcesContainer {
    func forcesListView() -> ForcesListViewController
    func forcesDetailView() -> ForcesDetailViewController
}

final class DefaultSLForcesContainer: SLContainer, SLForcesContainer {
    func forcesListView() -> ForcesListViewController {
        return makeForcesListView()
    }

    func forcesDetailView() -> ForcesDetailViewController {
        return makeForcesDetailView()
    }
}

private extension DefaultSLForcesContainer {

    // MARK: - Forces List dependencies
    private func makeForcesListRepository() -> ForcesRepository {
        return DefaultForcesRepository(dataTransferService: makeDataTransferService())
    }

    private func makeForcesListUseCase() -> ForcesListUseCase {
        return DefaultForcesListUseCase(forcesListRepository: makeForcesListRepository())
    }

    private func makeForcesListViewModel() -> ForcesListViewModel {
        return DefaultForcesListViewModel(forceListUseCase: makeForcesListUseCase())
    }

    // MARK: - Forces List View
    private func makeForcesListView() -> ForcesListViewController {
        let viewController = ForcesListViewController.instantiate(storyboardName: Constants.forcesListStoryboard)
        viewController.viewModel = makeForcesListViewModel()
        
        return viewController
    }

    // MARK: - Forces Detail dependencies
    private func makeForcesDetailUseCase() -> ForcesDetailUseCase {
        return DefaultForcesDetailUseCase(repository: makeForcesListRepository())
    }

    private func makeForcesDetailViewModel() -> ForcesDetailViewModel {
        return DefaultForcesDetailViewModel(forceDetailUseCase: makeForcesDetailUseCase())
    }

    // MARK: - Forces Detail View
    private func makeForcesDetailView() -> ForcesDetailViewController {
        let viewController = ForcesDetailViewController.instantiate(storyboardName: Constants.forcesDetailStoryboard)
        viewController.viewModel = makeForcesDetailViewModel()

        return viewController
    }
}

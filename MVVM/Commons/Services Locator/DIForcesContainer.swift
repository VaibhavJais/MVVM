//
//  DIForcesContainer.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 23/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import MVVMCommons

// MARK: - DIForcesContainer
final class DIForcesContainer {

    // MARK: - Properties
    private (set) var container: Container?
    private let appContainer = DIAppContainer()

    // MARK: - LifeCycle
    init() {
        setup()
    }

    private func setup() {
        container = Container()
            .register(ForcesListViewController.self) { resolve in
                return self.makeForcesListView()
        }
        .register(ForcesDetailViewController.self) { resolve in
            return self.makeForcesDetailView()
        }
    }

    // MARK: - Common
    private func makeDataTransferService() -> DataTransferService {
        return appContainer.container.resolve(DataTransferService.self)
    }

    // MARK: - Forces List
    private func makeForcesListRepository() -> ForcesRepository {
        return DefaultForcesRepository(dataTransferService: makeDataTransferService())
    }

    private func makeForcesListUseCase() -> ForcesListUseCase {
        return DefaultForcesListUseCase(forcesListRepository: makeForcesListRepository())
    }

    private func makeForcesListViewModel() -> ForcesListViewModel {
        return DefaultForcesListViewModel(forceListUseCase: makeForcesListUseCase())
    }

    private func makeForcesListView() -> ForcesListViewController {
        let viewController = ForcesListViewController.instantiate(storyboardName: "Main")
        viewController.viewModel = makeForcesListViewModel()
        return viewController
    }

    // MARK: - Forces Detail
    private func makeForcesDetailUseCase() -> ForcesDetailUseCase {
        return DefaultForcesDetailUseCase(repository: makeForcesListRepository())
    }

    private func makeForcesDetailViewModel() -> ForcesDetailViewModel {
        return DefaultForcesDetailViewModel(forceDetailUseCase: makeForcesDetailUseCase())
    }

    private func makeForcesDetailView() -> ForcesDetailViewController {
        let viewController = ForcesDetailViewController.instantiate(storyboardName: "ForcesDetailStoryboard")
        viewController.viewModel = makeForcesDetailViewModel()
        return viewController
    }
}

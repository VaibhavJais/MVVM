//
//  SLForcesContainer.swift
//  MVVM
//
//  Created by Oscar Cardona on 01/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

// MARK: - SLForcesContainer
final class SLForcesContainer {

    // MARK: - Properties
    private (set) var container: Container?
    private let appContainer = SLAppContainer()

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
}

private extension SLForcesContainer {
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
        let viewController = ForcesListViewController.instantiate(storyboardName: Constants.forcesListStoryboard)
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
        let viewController = ForcesDetailViewController.instantiate(storyboardName: Constants.forcesDetailStoryboard)
          viewController.viewModel = makeForcesDetailViewModel()
          return viewController
      }
}

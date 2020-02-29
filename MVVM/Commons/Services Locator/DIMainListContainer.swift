//
//  DIMainListContainer.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

final class DIMainListContainer {

    // MARK: - Properties
       private (set) var container: Container?
       private let appContainer = DIAppContainer()

       // MARK: - LifeCycle
       init() {
           setup()
       }

       private func setup() {
           container = Container()
               .register(MainListViewController.self) { resolve in
                   return self.makeMainListView()
           }
       }
}

private extension DIMainListContainer {
    // MARK: - Common
      private func makeDataTransferService() -> DataTransferService {
          return appContainer.container.resolve(DataTransferService.self)
      }

      // MARK: - Forces List
      private func makeMainListRepository() -> MainRepository {
          return DefaultMainRepository(dataTransferService: makeDataTransferService())
      }

      private func makeMainListUseCase() -> MainListUseCase {
          return DefaultMainListUseCase(repository: makeMainListRepository())
      }

      private func makeMainListViewModel() -> MainListViewModel {
          return DefaultMainListViewModel(mainListUseCase: makeMainListUseCase())
      }

      private func makeMainListView() -> MainListViewController {
        let viewController = MainListViewController.instantiate(storyboardName: Constants.mainListStoryboard)
          viewController.viewModel = makeMainListViewModel()
        
          return viewController
      }
}


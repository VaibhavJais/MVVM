//
//  MainListViewModel.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

// MARK: - MainListViewModel Protocol
protocol MainListViewModel: MainListViewModelInput, MainListViewModelOutput {}


// MARK: - MainListViewModelInput Protocol
protocol MainListViewModelInput {
    var items: Box<[MainListModel]?> { get }
    var loadingStatus: Box<LoadingStatus> { get }
    var error: SKRError? { get }
}

// MARK: - MainListViewModelOutput Protocol
protocol MainListViewModelOutput {
    func viewDidLoad()
    func updateView()
}

// MARK: - DefaultMainListViewModel
final class DefaultMainListViewModel {

    // MARK: private properties
    private let mainListUseCase: MainListUseCase
    private var mainListLoadTask: Cancellable? { willSet { mainListLoadTask?.cancel() } }

    // MARK: public propeties
    let items: Box<[MainListModel]?> = Box(nil)
    var error: SKRError?
    var loadingStatus: Box<LoadingStatus> = Box(.stop)

    // MARK: lifeCycle methods
    init(mainListUseCase: MainListUseCase) {
        self.mainListUseCase = mainListUseCase
    }
}

// MARK: - MainListViewModel
extension DefaultMainListViewModel: MainListViewModel {

    func viewDidLoad() {
        updateView()
    }

    func updateView() {
        self.loadingStatus.value = .start
        mainListLoadTask = mainListUseCase.execute(completion: { [weak self] result  in
            switch result {
            case .success(let mainListEntity):
                self?.updateViewSucces(mainListEntity: mainListEntity)
            case .failure(let error):
                self?.updateViewFailure(error: error)
            }
        })
    }

    private func updateViewSucces(mainListEntity: MainListEntity) {
        let viewData = DefaultMainListModel(mainListEntity: mainListEntity)
        print(viewData)
        DispatchQueue.main.async {
            //self.items.value = viewData.items
            self.loadingStatus.value = .stop
        }
    }

    private func updateViewFailure(error: Error) {
         DispatchQueue.main.async {
            //self.error.value = error
             self.loadingStatus.value = .stop
         }
     }
}


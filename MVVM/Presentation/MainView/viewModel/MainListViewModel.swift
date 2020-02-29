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
    var model: Box<MainListModel?> { get }
    var loadingStatus: Box<LoadingStatus?> { get }
    var error: Error? { get }
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

    // MARK: public propeties
    let model: Box<MainListModel?> = Box(nil)
    var error: Error?
    var loadingStatus: Box<LoadingStatus?> = Box(nil)

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
        mainListUseCase.execute(completion: { [weak self] result  in
            switch result {
            case .success(let mainListEntity):
                self?.updateViewSucces(mainListEntity: mainListEntity)
            case .failure(let error):
                self?.updateViewFailure(error: error)
            }
        })
    }

    private func updateViewSucces(mainListEntity: MainListEntity) {
        DispatchQueue.main.async {
            self.model.value = DefaultMainListModel(mainListEntity: mainListEntity)
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


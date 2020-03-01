//
//  HomeViewModel.swift
//  MVVM
//
//  Created by Oscar Cardona on 29/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

// MARK: - HomeViewModel Protocol
protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}


// MARK: - HomeViewModelInput Protocol
protocol HomeViewModelInput {
    var model: Box<HomeModel?> { get }
    var loadingStatus: Box<LoadingStatus?> { get }
    var error: Error? { get }
}

// MARK: - HomeViewModelOutput Protocol
protocol HomeViewModelOutput {
    func viewDidLoad()
    func updateView()
}

// MARK: - DefaultHomeistViewModel
final class DefaultHomeViewModel {

    // MARK: private properties
    private let homeUseCase: HomeUseCase

    // MARK: public propeties
    let model: Box<HomeModel?> = Box(nil)
    var error: Error?
    var loadingStatus: Box<LoadingStatus?> = Box(nil)

    // MARK: lifeCycle methods
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
}

// MARK: - HomeViewModel
extension DefaultHomeViewModel: HomeViewModel {

    func viewDidLoad() {
        updateView()
    }

    func updateView() {
        self.loadingStatus.value = .start
        homeUseCase.execute(completion: { [weak self] result  in
            switch result {
            case .success(let homeEntity):
                self?.updateViewSucces(homeEntity: homeEntity)
            case .failure(let error):
                self?.updateViewFailure(error: error)
            }
        })
    }

    private func updateViewSucces(homeEntity: HomeEntity) {
        DispatchQueue.main.async {
            self.model.value = DefaultHomeModel(homeEntity: homeEntity)
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


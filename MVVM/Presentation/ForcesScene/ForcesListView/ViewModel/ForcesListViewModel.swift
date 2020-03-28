//
//  ForcesListViewModel.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 14/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

// MARK: - ForcesListViewModel Protocol
protocol ForcesListViewModel: ForcesListViewModelInput, ForcesListViewModelOutput {}

// MARK: - ForcesListViewModel Input Protocol
protocol ForcesListViewModelInput {
    func viewDidLoad()
    func updateView()
    func showItemDetail(indexPath: IndexPath, coordinator: ForcesCoordinator?)
}

// MARK: - ForcesListViewModel Output Protocol
protocol ForcesListViewModelOutput {
    var items: Box<[ForcesListModel]?> { get }
    var loadingStatus: Box<LoadingStatus> { get }
    var error: Box<Error?> { get }
}

// MARK: - DefaultForcesListViewModel
final class DefaultForcesListViewModel {
    private let forcesListUseCase: ForcesListUseCase
    private var forcesLoadTask: Cancellable? { willSet { forcesLoadTask?.cancel() } }
    let items: Box<[ForcesListModel]?> = Box(nil)
    var error: Box<Error?> = Box(nil)
    var loadingStatus: Box<LoadingStatus> = Box(.stop)

    @discardableResult
    init(forceListUseCase: ForcesListUseCase) {
        self.forcesListUseCase = forceListUseCase
    }
}

// MARK: - ForcesListViewModel
extension DefaultForcesListViewModel: ForcesListViewModel {
    func viewDidLoad() {
        updateView()
    }

    func showItemDetail(indexPath: IndexPath, coordinator: ForcesCoordinator?) {
        guard let identifier = items.value?[indexPath.row].forcesId else {
            // TODO throws error
            return
        }
        coordinator?.forcesDetail(identifier: identifier)
    }

    public func updateView() {
        self.loadingStatus.value = .start
        forcesLoadTask = forcesListUseCase.execute(completion: { [weak self] result in
            switch result {
            case .success(let forcesList):
                let items =  forcesList.forces.map { DefaultForcesListModel(forces: $0) }
                DispatchQueue.main.async {
                    self?.items.value = items
                    self?.loadingStatus.value = .stop
                }
            case .failure(let error):
                self?.error.value = error
                self?.loadingStatus.value = .stop
            }
        })
    }
}

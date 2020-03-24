//
//  BeersListViewModel.swift
//  MVVM
//
//  Created by Oscar Cardona on 14/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools
import UIKit

protocol BeersListViewModel: BeersListViewModelInput, BeersListViewModelOutput {}

protocol BeersListViewModelInput {
    func viewDidLoad()
    func updateView()
    func image(url: String?, index: Int) -> Cancellable?
}

protocol BeersListViewModelOutput {
    var items: Box<BeersListModel?> { get }
    var loadingStatus: Box<LoadingStatus?> { get }
    var error: Box<Error?> { get }
}

final class DefaultBeersListViewModel {
    private let beersListUseCase: BeersListUseCase
    private var beersLoadTask: Cancellable? { willSet { beersLoadTask?.cancel() }}
    var items: Box<BeersListModel?> = Box(nil)
    var loadingStatus: Box<LoadingStatus?> = Box(.stop)
    var error: Box<Error?> = Box(nil)

    @discardableResult
    init(beersListUseCase: BeersListUseCase) {
        self.beersListUseCase = beersListUseCase
    }

    func viewDidLoad() {
        updateView()
    }
}

// MARK: Update View
extension DefaultBeersListViewModel: BeersListViewModel {
    func updateView() {
        self.loadingStatus.value = .start
        beersLoadTask = beersListUseCase.execute(completion: { (result) in
            switch result {
            case .success(let beers):
                let beers = beers.map { DefaultBeerModel(beer: $0) }
                self.items.value = DefaultBeersListModel(beers: beers)
            case .failure(let error):
                self.error.value = error
            }
            self.loadingStatus.value = .stop
        })
    }
}

// MARK: - Images
extension DefaultBeersListViewModel {
    func image(url: String?, index: Int) -> Cancellable? {
        guard let url = url else { return nil }
        return beersListUseCase.image(with: url, completion: { (result) in
            switch result {
            case .success(let imageData):
                self.items.value?.items?[index].image.value = imageData
            case .failure(let error ):
              print("image error: \(error)")
            }
        })
    }
}

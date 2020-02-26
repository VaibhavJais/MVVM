//
//  ForcesDetailViewModel.swift
//  Pattern MVVM
//
//  Created by Oscar Cardona on 22/02/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import Foundation
import SKRools

//MARK: - ForcesDetailViewModel
protocol ForcesDetailViewModel: ForcesDetailViewModelInput, ForcesDetailViewModelOutput {}

//MARK: - ForcesDetailViewModelInput
protocol ForcesDetailViewModelInput {
    var forcesIdentifier: String? { get set }

    func updateView(forcesId: String)
    func viewDidLoad()
}

//MARK: - ForcesDetailViewModelOutput
protocol ForcesDetailViewModelOutput {
    var items: Box<ForcesDetailModel?> { get }
    var loadingStatus: Box<LoadingStatus> { get }
    var error: Box<Error?> { get }
}

//MARK: - DefaultForcesDetailViewModel
final class DefaultForcesDetailViewModel: ForcesDetailViewModel {

    //MARK: - Properties
    private let forcesDetailUseCase: ForcesDetailUseCase
    private var forcesLoadTask: Cancellable? { willSet { forcesLoadTask?.cancel() } }
    let items: Box<ForcesDetailModel?> = Box(nil)
    var loadingStatus: Box<LoadingStatus> = Box(.stop)
    var error: Box<Error?> = Box(nil)
    var forcesIdentifier: String?

    //MARK: - LifeCycle
    @discardableResult
    init(forceDetailUseCase: ForcesDetailUseCase) {
        self.forcesDetailUseCase = forceDetailUseCase
    }

    func viewDidLoad() {
        if let identifier = forcesIdentifier {
            updateView(forcesId: identifier)
        }
    }

    //MARK: - Public Methods
    func updateView(forcesId: String) {
        self.loadingStatus.value = .start
        let requestValue = ForcesDetailRequestValue(queryString: forcesId)
        forcesLoadTask = forcesDetailUseCase.execute(requestValue: requestValue) { result in
            switch result {
            case .success(let item):
                let forceDetail = DefaultForcesDetailModel(forcesDetail: item)
                DispatchQueue.main.async { self.items.value = forceDetail }
            case .failure(let error):
                DispatchQueue.main.async { self.error.value = error }
            }
            DispatchQueue.main.async { self.loadingStatus.value = .stop }
        }
    }
}

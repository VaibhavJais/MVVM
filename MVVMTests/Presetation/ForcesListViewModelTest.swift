//
//  ForcesListViewModelTest.swift
//  MVVMTests
//
//  Created by Oscar Cardona on 04/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import XCTest
@testable import MVVM
@testable import SKRools

class ForcesListViewModelTest: XCTestCase {

    private enum ErrorMock: Error {
        case error
    }

    class ForcesListUseCseMock: ForcesListUseCase {
        var error: Error?
        var expt: XCTestExpectation?
        var forcesMock: ForcesListEntity = {
            let forceA = ForcesListItemEntity(forcesId: "forceA-id", forcesName: "Forces A")
            let forceB = ForcesListItemEntity(forcesId: "forceB-id", forcesName: "Forces B")
            let forceC = ForcesListItemEntity(forcesId: "forceC-id", forcesName: "Forces C")

            return ForcesListEntity(forces: [forceA, forceB, forceC])
        }()

        func execute(completion: @escaping (Result<ForcesListEntity, Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(forcesMock))
            }

            return nil
        }
    }

    func testWhenAPIReturnAllData() {
        let forcesListUseCaseMock = ForcesListUseCseMock()
        forcesListUseCaseMock.expt = self.expectation(description: "All OK")
        forcesListUseCaseMock.error = nil

        let viewModel = DefaultForcesListViewModel(forceListUseCase: forcesListUseCaseMock)

        viewModel.items.bind { (model) in
            guard let _ = model else { return }
            forcesListUseCaseMock.expt?.fulfill()
        }
        
        viewModel.updateView()

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(viewModel.items.value)
        XCTAssertNil(viewModel.error.value)
        XCTAssert(viewModel.loadingStatus.value == .stop)
    }


    func testWhenDataReturnsError() {
        let forcesListUseCaseMock = ForcesListUseCseMock()
        forcesListUseCaseMock.expt = self.expectation(description: "Error")
        forcesListUseCaseMock.error = ErrorMock.error

        let viewModel = DefaultForcesListViewModel(forceListUseCase: forcesListUseCaseMock)

        viewModel.error.bind { (error) in
            guard let _ = error else { return }
            forcesListUseCaseMock.expt?.fulfill()
        }

        viewModel.updateView()

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(viewModel.items.value)
        XCTAssertNotNil(viewModel.error.value)
        XCTAssert(viewModel.loadingStatus.value == .stop)
    }

}

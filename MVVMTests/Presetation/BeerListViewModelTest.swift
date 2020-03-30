//
//  BeerListViewModelTest.swift
//  MVVMTests
//
//  Created by Oscar Cardona on 20/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import XCTest
@testable import MVVM
@testable import SKRools

class BeerListViewModelTest: XCTestCase {
    private enum ErrorMock: Error {
        case error
    }

    class BeersListUseCaseMock: BeersListUseCase {

        var error: Error?
        var expt: XCTestExpectation?

        func execute(completion: @escaping (Result<[BeerEntity], Error>) -> Void) -> Cancellable? {
            let beersMock = BeersMock.makeBeerListEntityMock()
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(beersMock))
            }
            expt?.fulfill()
            return nil
        }

        func image(with imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
            return nil
        }
    }

    func testWhenAPIReturnAllData() {
        let beersListUseCaseMock = BeersListUseCaseMock()
        beersListUseCaseMock.expt = self.expectation(description: "All OK")
        beersListUseCaseMock.error = nil

        let viewModel = DefaultBeersListViewModel(beersListUseCase: beersListUseCaseMock)


        viewModel.items.bind { (_) in}
        viewModel.updateView()

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(viewModel.items.value)
        XCTAssertNil(viewModel.error.value)
        XCTAssert(viewModel.loadingStatus.value == .stop)
    }

    func testWhenDataReturnsError() {
        let beersListUseCaseMock = BeersListUseCaseMock()
        beersListUseCaseMock.expt = self.expectation(description: "Error")
        beersListUseCaseMock.error = ErrorMock.error

        let viewModel = DefaultBeersListViewModel(beersListUseCase: beersListUseCaseMock)

        viewModel.updateView()

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(viewModel.items.value)
        XCTAssertNotNil(viewModel.error.value)
        XCTAssert(viewModel.loadingStatus.value == .stop)
    }
}

//
//  ForcesListUseCaseTest.swift
//  MVVMTests
//
//  Created by Oscar Cardona on 28/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import XCTest
@testable import MVVM
@testable import SKRools


class ForcesListUseCaseTest: XCTestCase {

    enum ForcesRepositorySuccessTestError: Error {
        case failedFetching
    }

    class ForcesListRepositorySuccessMock: ForcesRepository {
        var expt: XCTestExpectation?

        func forcesList(completion: @escaping (Result<ForcesListEntity, Error>) -> Void) -> Cancellable? {
            completion(.success(ForcesMock.makeForcesListEntityMock()))
            return nil
        }

        func forcesDetail(query: ForcesDetailRequestValue, completion: @escaping (Result<ForcesDetailEntity, Error>) -> Void) -> Cancellable? {
            return nil
        }
    }

    class ForcesListRepositoryFailureMock: ForcesRepository {
        var expt: XCTestExpectation?

        func forcesList(completion: @escaping (Result<ForcesListEntity, Error>) -> Void) -> Cancellable? {
            completion(.failure(ForcesRepositorySuccessTestError.failedFetching))
            return nil
        }

        func forcesDetail(query: ForcesDetailRequestValue, completion: @escaping (Result<ForcesDetailEntity, Error>) -> Void) -> Cancellable? {
            return nil
        }
    }

    func testForcesListUseCase_whenSuccessfully() {
        let useCase = DefaultForcesListUseCase(forcesListRepository: ForcesListRepositorySuccessMock())

        _ = useCase.execute(completion: { (result) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            default:
                assertionFailure("Error should be empty")
            }
        })
    }

    func testForcesListUseCase_whenFailure() {
        let useCase = DefaultForcesListUseCase(forcesListRepository: ForcesListRepositoryFailureMock())

        _ = useCase.execute(completion: { (result) in

            switch result {
            case .success:
                assertionFailure("Data should be empty")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }
}

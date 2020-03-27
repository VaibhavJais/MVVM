//
//  BeersListUseCaseTest.swift
//  MVVMTests
//
//  Created by Oscar Cardona on 27/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import XCTest
@testable import MVVM
@testable import SKRools

class BeersListUseCaseTest: XCTestCase {

    enum ExternalRepositorySuccessTestError: Error {
        case failedFetching
    }

    class ExternalRepositorySuccessMock: ExternalRepository {
        var imageData: Data?
        var expt: XCTestExpectation?

        init() {
            if let asset = UIImage(named: Constants.defaultImage) {
                imageData = asset.pngData()
            }
        }

        func image(with imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
            guard let imageData = imageData else {
                assertionFailure("Default image not found")
                return nil
            }
            expt?.fulfill()
            completion(.success(imageData))

            return nil
        }
    }

    class ExternalRepositoryFailureMock: ExternalRepository {
        func image(with imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
            completion(.failure(ExternalRepositorySuccessTestError.failedFetching))
            return nil
        }
    }


    class BeerRepositoryFailureMock: BeersRepository {
        func beersList(completion: @escaping (Result<[BeerEntity], Error>) -> Void) -> Cancellable? {
            completion(.failure(ExternalRepositorySuccessTestError.failedFetching))
            return nil
        }
    }

    class BeerRepositorySuccessMock: BeersRepository {
        func beersList(completion: @escaping (Result<[BeerEntity], Error>) -> Void) -> Cancellable? {
            completion(.success(BeersMock.makeBeerListEntityMock()))
            return nil
        }
    }

    func testExternalUseCase_whenSuccessfully() {
        let useCase = DefaultBeersListUseCase(beersRepository: BeerRepositorySuccessMock(),
                                              externalRepository: ExternalRepositorySuccessMock())

        _ = useCase.image(with: "", completion: { (result) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        })
    }

    func testExternalUseCase_whenFailure() {
        let useCase = DefaultBeersListUseCase(beersRepository: BeerRepositorySuccessMock(),
                                              externalRepository: ExternalRepositoryFailureMock())

        _ = useCase.image(with: "", completion: { (result) in
            switch result {
            case .success(let data):
                XCTAssertNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }

    func testBeerListUseCase_whenSuccessfully() {
        let useCase = DefaultBeersListUseCase(beersRepository: BeerRepositorySuccessMock(),
                                              externalRepository: ExternalRepositorySuccessMock())

        _ = useCase.execute(completion: { (result) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        })
    }

    func testBeerListExternalUseCase_whenFailure() {
        let useCase = DefaultBeersListUseCase(beersRepository: BeerRepositoryFailureMock(),
                                              externalRepository: ExternalRepositorySuccessMock())

        _ = useCase.execute(completion: { (result) in
            switch result {
            case .success(let data):
                XCTAssertNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }

    func testBeerDecoding_whenSuccess() throws {
        let result = try JSONDecoder().decode(BeerEntity.self, from: BeersMock.makeBeersListJsonMock())
        let beer = DefaultBeerModel(beer: result)
        let beerList = DefaultBeersListModel(beers: [beer])

        XCTAssertNotNil(result)
        XCTAssertNotNil(beer)
        XCTAssertNotNil(beerList)
    }
}

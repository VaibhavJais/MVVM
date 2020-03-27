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
            completion(.success(makeBeerListEntityMock()))
            return nil
        }
    }

    func testExternalUseCase_whenSuccessfully() {
        // given
        let useCase = DefaultBeersListUseCase(beersRepository: BeerRepositorySuccessMock(),
                                              externalRepository: ExternalRepositorySuccessMock())

        // when
        _ = useCase.image(with: "", completion: { (result) in
            // Then
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        })
    }

    func testExternalUseCase_whenFailure() {
        // given
        let useCase = DefaultBeersListUseCase(beersRepository: BeerRepositorySuccessMock(),
                                              externalRepository: ExternalRepositoryFailureMock())

        // when
        _ = useCase.image(with: "", completion: { (result) in
            // Then
            switch result {
            case .success(let data):
                XCTAssertNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }

    func testBeerListUseCase_whenSuccessfully() {
        // given
        let useCase = DefaultBeersListUseCase(beersRepository: BeerRepositorySuccessMock(),
                                              externalRepository: ExternalRepositorySuccessMock())

        _ = useCase.execute(completion: { (result) in
            // Then
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        })
    }

    func testBeerListExternalUseCase_whenFailure() {
        // given
        let useCase = DefaultBeersListUseCase(beersRepository: BeerRepositoryFailureMock(),
                                              externalRepository: ExternalRepositorySuccessMock())

        // when
        _ = useCase.execute(completion: { (result) in
            // Then
            switch result {
            case .success(let data):
                XCTAssertNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }
}

extension BeersRepository {
    func makeBeerListEntityMock() -> [BeerEntity] {
        let volume = Volume(value: 1, unit: "kg")
        let boil = BoilVolume(value: 2, unit: "kg")
        let temp = Temp(value: 1, unit: "c")
        let mashTemp = MashTemp(temp: temp, duration: 3)
        let fermentation = Fermentatiom(temp: temp)
        let beerMethod = BeerMethod(mashTemp: [mashTemp], fermentation: fermentation, twist: "twist")
        let amount = Amount(value: 2.3, unit: "kg")
        let malt = Malt(name: "malt name", amount: amount)
        let hops = Hops(name: "hop name", amount: amount, add: "no", attribute: "attribu")
        let ingredients = Ingredients(malt: [malt], hops: [hops], yeast: "yeast")
        let beerA = BeerEntity(identifier: "123",
                               name: "Beer Test",
                               tagline: "Tag line",
                               firstBrewed: "21/2209",
                               description: "beer description",
                               imageUrl: "http://fake.url",
                               abv: 21.0,
                               ibu: 12.9,
                               targetFg: 10,
                               targetOg: 20,
                               ebc: 2.3,
                               srm: 1.2,
                               ph: 4.3,
                               attenuationLevel: 4.4,
                               volume: volume,
                               boilVolume: boil,
                               method: beerMethod,
                               ingredients: ingredients,
                               foodPairing: ["chees"],
                               brewersTips: "tips",
                               contributedBy: "contr")
        return [beerA]
    }
}

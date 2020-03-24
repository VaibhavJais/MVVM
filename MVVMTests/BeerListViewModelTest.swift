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
            let beersMock = makeBeerListEntityMock()
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
        // Given
        let beersListUseCaseMock = BeersListUseCaseMock()
        beersListUseCaseMock.expt = self.expectation(description: "All OK")
        beersListUseCaseMock.error = nil

        let viewModel = DefaultBeersListViewModel(beersListUseCase: beersListUseCaseMock)

        // When
        viewModel.updateView()

        // Then
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(viewModel.items.value)
        XCTAssertNil(viewModel.error.value)
    }

    func testWhenDataReturnsError() {
        // Given
        let beersListUseCaseMock = BeersListUseCaseMock()
        beersListUseCaseMock.expt = self.expectation(description: "Error")
        beersListUseCaseMock.error = ErrorMock.error

        let viewModel = DefaultBeersListViewModel(beersListUseCase: beersListUseCaseMock)

        // When
        viewModel.updateView()

        // Then
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(viewModel.items.value)
        XCTAssertNotNil(viewModel.error.value)
    }
}

extension BeersListUseCase {
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

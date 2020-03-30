//
//  MVVMUITest.swift
//  MVVMUITests
//
//  Created by Oscar Cardona on 28/03/2020.
//  Copyright © 2020 Cardona.tv. All rights reserved.
//

import XCTest

class MVVMUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testHomeViewController_whenCollectionViewSuccess() {
        let cell1 = app.staticTexts["Forces"]
        let cell2 = app.staticTexts["PunkAPI"]
        let cell3 = app.staticTexts["Settings"]

        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: cell1, handler: nil)
        expectation(for: exists, evaluatedWith: cell2, handler: nil)
        expectation(for: exists, evaluatedWith: cell3, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testForcesListViewController_whenCollectionViewSuccess() {
        app.collectionViews.cells.element(boundBy:0).tap()

        let label = app.staticTexts["City of London Police"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testForcesDetailViewController_whenCollectionViewSuccess() {

//        app.collectionViews.cells.element(boundBy:0).tap()
//        let label = app.staticTexts["City of London Police"]
//        let exists = NSPredicate(format: "exists == 1")
//
//        expectation(for: exists, evaluatedWith: label, handler: nil)
//        waitForExpectations(timeout: 5, handler: nil)
//
//        let tablesQuery = app.tables
//        let cellQuery = tablesQuery.cells.containing(.staticText, identifier: "CellAcceptedReuseID")
//        let cell = cellQuery.children(matching: .staticText)
//        let cellElement = cell.element
//        cellElement.tap()
//
//        let text = app.staticTexts["Community Policing is the"]
//        let existsDetail = NSPredicate(format: "exists == 1")
//        expectation(for: existsDetail, evaluatedWith: text, handler: nil)
//        waitForExpectations(timeout: 5, handler: nil)

    }

    func testBeersListViewController_whenCollectionViewSuccess() {
        app.collectionViews.cells.element(boundBy:1).tap()

        let label = app.staticTexts["Buzz"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

    }
}

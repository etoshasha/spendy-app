//
//  SpendyAppUITests.swift
//  SpendyAppUITests
//
//  Created by A B on 01.12.2023.
//

import XCTest

final class SpendyAppUITests: XCTestCase {
  var app: XCUIApplication!
  // swiftlint:disable:previous implicitly_unwrapped_optional

  override func setUpWithError() throws {
    app = XCUIApplication()
    app.launch()
    continueAfterFailure = false
  }

  func test_addReceiptButton() throws {
    let addReceiptButton = app.buttons["Add receipt"]
    addReceiptButton.tap()
    XCTAssert(addReceiptButton.exists)
  }

  func test_receiptView() throws {
    let historyTabBarButton = app.tabBars["Tab Bar"].buttons["History"]
    let homeTabBarButton = app.tabBars["Tab Bar"].buttons["Home"]

    historyTabBarButton.tap()
    homeTabBarButton.tap()
    XCTAssert(historyTabBarButton.exists)
  }

  func test_editButton() throws {
    let historyTabBarButton = app.tabBars["Tab Bar"].buttons["History"]
    let doneEditButton = app.navigationBars["All Receipts"].buttons["Done"]
    let editButton = app.navigationBars["All Receipts"].buttons["Edit"]
    let initialCellCount = app.collectionViews.cells.count

    historyTabBarButton.tap()
    editButton.tap()
    doneEditButton.tap()

    XCTAssertFalse(app.collectionViews.cells.count == initialCellCount - 1)
  }
}

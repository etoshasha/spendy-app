//
//  SpendyAppTests.swift
//  SpendyAppTests
//
//  Created by A B on 01.12.2023.
//

import XCTest
@testable import SpendyApp

final class SpendyAppTests: XCTestCase {
  let timeout: TimeInterval = 6
  var currencyService: CurrencyService!
  // swiftlint:disable:previous implicitly_unwrapped_optional

  override func setUp() {
    super.setUp()
    currencyService = CurrencyService()
  }

  override func tearDown() {
    currencyService = nil
    super.tearDown()
  }

  func test_noServerResponse() {
    let expectation = expectation(description: "Server responds in reasonable time")
    // swiftlint:disable:next force_unwrapping
    let url = URL(string: "freecurrency")!
    URLSession.shared.dataTask(with: url) { data, response, error in
      expectation.fulfill()
      XCTAssertNil(data)
      XCTAssertNil(response)
      XCTAssertNotNil(error)
    }
    .resume()

    waitForExpectations(timeout: timeout)
  }

  func test_GetCurrencyRatesSuccess() async throws {
    let baseCurrency = "USD"

    do {
      let currencyRates = try await currencyService.getCurrencyRates(for: baseCurrency)
      XCTAssertNotNil(currencyRates, "Currency rates should not be nil")
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }

  func test_GetCurrencyRatesInvalidResponse() async {
    let invalidBaseCurrency = "LLL"

    do {
      _ = try await currencyService.getCurrencyRates(for: invalidBaseCurrency)
      XCTFail("Expected error, but call succeeded.")
    } catch CurrencyService.Errors.invalidResponse {
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }
}

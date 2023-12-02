//
//  CurrencyService.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import Foundation

class CurrencyService: ObservableObject {
  enum Errors: Error {
    case invalidURL
    case invalidResponse
    case failedToDecode
    case failedToGet
    case failedToDownload
  }

  private var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "FCAPI-Info", ofType: "plist") else {
      fatalError("Couldn't find file 'FCAPI-Info.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find 'API_KEY' in 'FCAPI-Info.plist'.")
    }
    return value
  }

  let baseURLString = "https://api.freecurrencyapi.com/v1/"
  let session = URLSession.shared
  let decoder = JSONDecoder()

  func getCurrencyRates(for baseCurrency: String) async throws -> CurrencyRates? {
    let currencyRates: CurrencyRates?

    guard var urlComponents = URLComponents(string: baseURLString + "latest") else {
      return nil
    }

    urlComponents.queryItems = [URLQueryItem(name: "base_currency", value: baseCurrency)]
    guard let queryURL = urlComponents.url else { throw Errors.invalidURL }
    var request = URLRequest(url: queryURL)
    request.setValue(apiKey, forHTTPHeaderField: "apikey")

    let (data, response) = try await session.data(for: request)
    guard
      let httpResponse = response as? HTTPURLResponse,
      (200..<300).contains(httpResponse.statusCode)
    else {
      throw Errors.invalidResponse
    }

    do {
      currencyRates = try decoder.decode(CurrencyRates.self, from: data)
    } catch {
      throw Errors.failedToDecode
    }
    return currencyRates
  }
}

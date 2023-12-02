//
//  ReceiptStore.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import Foundation

struct Receipt: Identifiable, Hashable, Codable {
  var id = UUID()
  var name: String
  var category: Category
  var totalAmount: Double
  var currency: Currencies
  var date: Date
  var items: String
  var exchangeRates: CurrencyRates
}

class ReceiptStore: ObservableObject {
  enum ReceiptErrors: String, Error {
    case failedToSaveData = "Error: failed to save the receipt information. Try again later"
    case failedToLoadData = "Error: failed to load the receipt information. Try again later"
    case failedToConvert = "Error: unable to convert the amount. Check your networking connection or try again later"
  }

  let service = CurrencyService()
  let receiptsJSONURL = FileManager.documentsDirectoryURL
    .appendingPathComponent("Receipts")
    .appendingPathExtension("json")

  @Published var addingReceipt = false
  @Published var receipts: [Receipt] = [
    Receipt(
      name: "Pande Putri",
      category: .groceries,
      totalAmount: 580300.2,
      currency: .idr,
      date: Date(),
      items: "Milk, apples, chocolate, napkins",
      exchangeRates: CurrencyRates(data: ["USD": 0.000064])
    ),
    Receipt(
      name: "Guardian",
      category: .healthcare,
      totalAmount: 15.0,
      currency: .usd,
      date: Date(),
      items: "Ibuprophen",
      exchangeRates: CurrencyRates(data: ["USD": 1])),
    Receipt(
      name: "Grandlucky",
      category: .groceries,
      totalAmount: 300.2,
      currency: .cad,
      date: Date(),
      items: "Cat food, banana, mango, orange juice, chicken breast, ground beef, cheese, burger buns",
      exchangeRates: CurrencyRates(data: ["USD": 0.74])),
    Receipt(
      name: "Lilla Pantai",
      category: .cafe,
      totalAmount: 100300.2,
      currency: .idr,
      date: Date(),
      items: "Coffee, avocado toast",
      exchangeRates: CurrencyRates(data: ["USD": 0.000064])),
    Receipt(
      name: "Level XXI",
      category: .entertainment,
      totalAmount: 300,
      currency: .hkd,
      date: Date(),
      items: "2x Tickets to the cinema",
      exchangeRates: CurrencyRates(data: ["USD": 0.13])),
    Receipt(
      name: "Gas",
      category: .transport,
      totalAmount: 32000,
      currency: .idr,
      date: Date(),
      items: "Gas for bike",
      exchangeRates: CurrencyRates(data: ["USD": 0.000064])),
    Receipt(
      name: "Koa Shala",
      category: .personal,
      totalAmount: 300000,
      currency: .idr,
      date: Date(),
      items: "Balinese massage",
      exchangeRates: CurrencyRates(data: ["USD": 0.000064])),
    Receipt(
      name: "UNIQLO",
      category: .clothing,
      totalAmount: 10500,
      currency: .thb,
      date: Date(),
      items: "3x White T-shirts, 3x Socks, 1x Shorts",
      exchangeRates: CurrencyRates(data: ["USD": 0.028])),
    Receipt(
      name: "Trip.com",
      category: .travel,
      totalAmount: 5200000,
      currency: .idr,
      date: Date(),
      items: "Round-trip tickets to Bangkok",
      exchangeRates: CurrencyRates(data: ["USD": 0.000064]))
  ] {
    didSet {
      saveReceipt()
    }
  }

  init() {
    loadReceipts()
  }

  @MainActor
  // swiftlint:disable all
  func addReceipt(
    name: String,
    category: Category,
    totalAmount: Double,
    currency: Currencies,
    date: Date,
    items: String
  ) async throws {
    guard let currencyRates = try await service.getCurrencyRates(for: currency.description) else {
      throw ReceiptErrors.failedToConvert
    }
    receipts.append(Receipt(
      name: name,
      category: category,
      totalAmount: totalAmount,
      currency: currency,
      date: date,
      items: items,
      exchangeRates: currencyRates)
    )
  }
  // swiftlint:enable all

  private func loadReceipts() {
    guard FileManager.default.fileExists(atPath: receiptsJSONURL.path) else {
      return
    }

    let decoder = JSONDecoder()

    do {
      let receiptsData = try Data(contentsOf: receiptsJSONURL)
      receipts = try decoder.decode([Receipt].self, from: receiptsData)
    } catch {
      print(ReceiptErrors.failedToLoadData.rawValue)
    }
  }

  private func saveReceipt() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
      let receiptsData = try encoder.encode(receipts)
      try receiptsData.write(to: receiptsJSONURL, options: .atomic)
    } catch {
      print(ReceiptErrors.failedToSaveData.rawValue)
    }
  }

  func convertAmount(amount: Double, from receiptCurrency: String, to mainCurrency: String) async throws -> Double? {
    guard let currencyRates = try await service.getCurrencyRates(for: receiptCurrency) else {
      throw ReceiptErrors.failedToConvert
    }
    // swiftlint:disable:next force_unwrapping
    let mainConversion = currencyRates.data[mainCurrency]!
    let convertedAmount = mainConversion * amount
    return convertedAmount
  }
}

enum Category: CaseIterable, Identifiable, CustomStringConvertible, Codable {
  case groceries
  case restaurants
  case cafe
  case healthcare
  case entertainment
  case transport
  case clothing
  case travel
  case personal

  var id: Self { self }

  var description: String {
    switch self {
    case .groceries:
      return "Groceries"
    case .restaurants:
      return "Restaurants"
    case .cafe:
      return "Cafe"
    case .healthcare:
      return "Healthcare"
    case .entertainment:
      return "Entertainment"
    case .transport:
      return "Transport"
    case .clothing:
      return "Clothing and Accessories"
    case .travel:
      return "Travel"
    case .personal:
      return "Personal Care"
    }
  }

  var image: String {
    switch self {
    case .groceries:
      return "groceries"
    case .restaurants:
      return "restaurants"
    case .cafe:
      return "cafe"
    case .healthcare:
      return "healthcare"
    case .entertainment:
      return "entertainment"
    case .transport:
      return "transport"
    case .clothing:
      return "clothing"
    case .travel:
      return "travel"
    case .personal:
      return "personal"
    }
  }
}

enum Currencies: CaseIterable, Identifiable, CustomStringConvertible, Codable {
  case usd
  case cad
  case eur
  case hkd
  case idr
  case thb

  var id: Self { self }

  var description: String {
    switch self {
    case .usd:
      return "USD"
    case .cad:
      return "CAD"
    case .eur:
      return "EUR"
    case .hkd:
      return "HKD"
    case .idr:
      return "IDR"
    case .thb:
      return "THB"
    }
  }
}

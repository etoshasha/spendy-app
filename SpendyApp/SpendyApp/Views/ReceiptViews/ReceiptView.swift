//
//  ReceiptView.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import SwiftUI

struct ReceiptView: View {
  @Binding var receipt: Receipt
  @Environment(\.verticalSizeClass)
  var verticalSizeClass
  var body: some View {
    if verticalSizeClass == .compact {
      LandscapeReceiptView(receipt: $receipt, receiptStore: ReceiptStore(), settingsStore: SettingsStore())
    } else {
      PortraitReceiptView(receipt: $receipt, receiptStore: ReceiptStore(), settingsStore: SettingsStore())
    }
  }
}

struct ReceiptView_Previews: PreviewProvider {
  static var previews: some View {
    ReceiptView(receipt: .constant(Receipt(
      name: "Pande Putri",
      category: .groceries,
      totalAmount: 580300.200,
      currency: .idr,
      date: Date(),
      items: "Milk, apples, chocolate, napkins",
      exchangeRates: CurrencyRates(data: ["USD": 0.000064]))))
  }
}

struct PortraitReceiptView: View {
  @Binding var receipt: Receipt
  @ObservedObject var receiptStore: ReceiptStore
  @ObservedObject var settingsStore: SettingsStore
  @MainActor var mainCurrencyConversion: String {
    let conversionRate = receipt.exchangeRates.data[settingsStore.settings.mainCurrency.description] ?? 0.0
    let convertedAmount = conversionRate * receipt.totalAmount
    return "\(String(format: "%.2f", convertedAmount)) \(settingsStore.settings.mainCurrency.description)"
      }

  var body: some View {
    VStack {
      HStack {
        CategotyImageView(receiptCategory: $receipt.category)
        VStack {
          Text(receipt.name)
            .font(.largeTitle)
          Text(receipt.date, style: .date)
        }
        .padding()
      }
      HStack {
        Spacer()
        Text(receipt.category.description)
          .foregroundColor(.gray)
      }
      .padding(5)
      HStack(alignment: .firstTextBaseline) {
        Text("Total amount:")
          .font(.headline)
        Spacer()
        VStack(alignment: .trailing) {
          Text("\(String(format: "%.2f", receipt.totalAmount)) \(receipt.currency.description)")
            .font(.headline)
          Text(mainCurrencyConversion)
            .foregroundColor(.gray)
            .font(.headline)
        }
      }
      .padding(5)
      Divider()
      List {
        let itemsArray = receipt.items.split(separator: ", ")
        ForEach(itemsArray, id: \.self) { item in
          Text(item.capitalized)
        }
      }
      .listStyle(.plain)
      Spacer()
    }
    .padding()
  }
}

struct LandscapeReceiptView: View {
  @Binding var receipt: Receipt
  @ObservedObject var receiptStore: ReceiptStore
  @ObservedObject var settingsStore: SettingsStore
  @MainActor var mainCurrencyConversion: String {
    let conversionRate = receipt.exchangeRates.data[settingsStore.settings.mainCurrency.description] ?? 0.0
    let convertedAmount = conversionRate * receipt.totalAmount
    return "\(String(format: "%.2f", convertedAmount)) \(settingsStore.settings.mainCurrency.description)"
      }

  var body: some View {
    HStack {
      VStack {
        HStack {
          CategotyImageView(receiptCategory: $receipt.category)
          VStack {
            Text(receipt.name)
              .font(.largeTitle)
            Text(receipt.date, style: .date)
          }
          .padding()
        }
        HStack {
          Spacer()
          Text(receipt.category.description)
            .foregroundColor(.gray)
        }
        .padding(5)
        HStack(alignment: .firstTextBaseline) {
          Text("Total amount:")
            .font(.headline)
          Spacer()
          VStack(alignment: .trailing) {
            Text("\(String(format: "%.2f", receipt.totalAmount)) \(receipt.currency.description)")
              .font(.headline)
            Text(mainCurrencyConversion)
              .foregroundColor(.gray)
              .font(.headline)
          }
        }
        .padding(5)
      }
      List {
        let itemsArray = receipt.items.split(separator: ", ")
        ForEach(itemsArray, id: \.self) { item in
          Text(item.capitalized)
        }
      }
      .listStyle(.plain)
    }
  }
}

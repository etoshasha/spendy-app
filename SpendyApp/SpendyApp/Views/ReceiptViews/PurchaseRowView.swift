//
//  PurchaseRowView.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import SwiftUI

struct PurchaseRowView: View {
  @State var receipt: Receipt
  @ObservedObject var settingsStore: SettingsStore
  @ObservedObject var receiptStore: ReceiptStore
  @MainActor var mainCurrencyConversion: String {
    let conversionRate = receipt.exchangeRates.data[settingsStore.settings.mainCurrency.description] ?? 0.0
    let convertedAmount = conversionRate * receipt.totalAmount
    return "\(String(format: "%.2f", convertedAmount)) \(settingsStore.settings.mainCurrency.description)"
      }

  var body: some View {
    HStack {
      CategotyImageView(receiptCategory: $receipt.category)
        .frame(maxWidth: 40, maxHeight: 40)
      HStack {
        VStack(alignment: .leading) {
          Text(receipt.name)
            .font(.headline)
          Text(receipt.date, style: .date)
            .font(.caption)
        }
        Spacer()
        VStack(alignment: .trailing) {
          Text("\(String(format: "%.2f", receipt.totalAmount)) \(receipt.currency.description)")
          HStack {
            Text(mainCurrencyConversion)
              .foregroundColor(.gray)
          }
        }
        .font(.subheadline)
      }
    }
  }
}

struct PurchaseRowView_Previews: PreviewProvider {
  static var previews: some View {
    PurchaseRowView(
      receipt: Receipt(
      name: "Pande Putri",
      category: .groceries,
      totalAmount: 580300.200,
      currency: .idr,
      date: Date(),
      items: "Milk, apples, chocolate, napkins",
      exchangeRates: CurrencyRates(data: ["USD": 0.000064])),
      settingsStore: SettingsStore(),
      receiptStore: ReceiptStore())
  }
}

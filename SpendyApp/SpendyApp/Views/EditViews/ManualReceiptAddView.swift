//
//  ManualReceiptAddView.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import SwiftUI

struct ManualReceiptAddView: View {
  @Environment(\.dismiss)
  var dismiss
  @ObservedObject var receiptStore: ReceiptStore
  @ObservedObject var settingsStore: SettingsStore
  @State var name = ""
  @State var pickedCategory: Category = .cafe
  @State var pickedCurrency: Currencies = .idr
  @State var totalAmount = Double()
  @State var date = Date()
  @State var items = ""

  private var numberFormatter: NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter
  }

  var body: some View {
    NavigationStack {
      Form {
        Section("Shop name") {
          TextField("", text: $name, prompt: Text("Name"))
        }
        CategoryPickerView(pickedCategory: $pickedCategory)
        HStack {
          TextField("", value: $totalAmount, formatter: numberFormatter)
            .keyboardType(.decimalPad)
          CurrencyPickerView(pickedCurrency: $pickedCurrency)
        }
        DatePicker("Date of purchase", selection: $date, displayedComponents: .date)
        Section("Items") {
          TextField("", text: $items, axis: .vertical)
            .lineLimit(5...)
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            receiptStore.addingReceipt = false
            dismiss()
          } label: {
            Text("Cancel")
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            Task {
              try await receiptStore.addReceipt(
                name: name,
                category: pickedCategory,
                totalAmount: totalAmount,
                currency: pickedCurrency,
                date: date,
                items: items)
              receiptStore.addingReceipt = false
              dismiss()
            }
          } label: {
            Text("Add")
          }
          .disabled(name.isEmpty)
        }
      }
      .navigationTitle(Text("Add your receipt here"))
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct ManualReceiptAddView_Previews: PreviewProvider {
  static var previews: some View {
    ManualReceiptAddView(
      receiptStore: ReceiptStore(), settingsStore: SettingsStore())
  }
}

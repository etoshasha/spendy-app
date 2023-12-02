//
//  HomeView.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var receiptStore: ReceiptStore
  @ObservedObject var settingsStore: SettingsStore

  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        VStack {
          Text("Choose the main currency\n for converting your receipts")
            .bold()
            .multilineTextAlignment(.center)
          CurrencyPickerView(pickedCurrency: $settingsStore.settings.mainCurrency)
            .pickerStyle(.wheel)
        }
        AddButtonView(receiptStore: receiptStore, settingsStore: settingsStore)
        Spacer()
      }
    }
  }
}


struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(receiptStore: ReceiptStore(), settingsStore: SettingsStore())
  }
}

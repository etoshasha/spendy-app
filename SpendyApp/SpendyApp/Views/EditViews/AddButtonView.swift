//
//  AddButtonView.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import SwiftUI

struct AddButtonView: View {
  @ObservedObject var receiptStore: ReceiptStore
  @ObservedObject var settingsStore: SettingsStore

  var body: some View {
    ZStack {
      Button {
        receiptStore.addingReceipt.toggle()
      } label: {
        Text("Add receipt")
          .font(.title)
          .frame(minWidth: 100, maxWidth: 200, minHeight: 80)
      }
      .buttonStyle(.borderedProminent)
      .tint(Color(red: 0.67, green: 0.7, blue: 0.99))
      .sheet(isPresented: $receiptStore.addingReceipt) {
        ManualReceiptAddView(receiptStore: receiptStore, settingsStore: settingsStore)
      }
    }
    .padding(40)
  }
}
struct AddButtonView_Previews: PreviewProvider {
  static var previews: some View {
    AddButtonView(receiptStore: ReceiptStore(), settingsStore: SettingsStore())
  }
}

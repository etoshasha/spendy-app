//
//  ReceiptTabView.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import SwiftUI

struct ReceiptTabView: View {
  @ObservedObject var receiptStore: ReceiptStore
  @ObservedObject var settingsStore: SettingsStore
  @State private var isPopoverPresented = false

  var body: some View {
    NavigationStack {
      if receiptStore.receipts.isEmpty {
        VStack {
          Text("No receipts added")
            .foregroundColor(Color(.darkGray))
          Text("Go to the Home tab and add your receipts")
            .foregroundColor(Color(.darkGray))
        }
      } else {
        List {
          ForEach(receiptStore.receipts, id: \.id) { receipt in
            NavigationLink(value: receipt) {
              PurchaseRowView(receipt: receipt, settingsStore: settingsStore, receiptStore: receiptStore)
            }
            .navigationDestination(for: Receipt.self) { receipt in
              if let selectedReceipt = $receiptStore.receipts.first(where: { $0.id == receipt.id }) {
                ReceiptView(receipt: selectedReceipt)
              }
            }
          }
          .onDelete { indexSet in
            receiptStore.receipts.remove(atOffsets: indexSet)
          }
        }
        .listStyle(.plain)
        .navigationTitle("All Receipts")
        .toolbar {
          ToolbarItemGroup {
            EditButton()
            Image(systemName: "exclamationmark.bubble")
              .foregroundColor(Color.blue)
              .onTapGesture {
                isPopoverPresented.toggle()
              }
              .popover(isPresented: $isPopoverPresented, arrowEdge: .top) {
                VStack(alignment: .center) {
                  Text("If the converted amount shows 0.00, check your network connection or restart the app")
                    .multilineTextAlignment(.center)
                    .padding()
                  Button("Dismiss") {
                    isPopoverPresented.toggle()
                  }
                }
              }
          }
        }
      }
    }
  }
}


struct ReceiptTabView_Previews: PreviewProvider {
  static var previews: some View {
    ReceiptTabView(receiptStore: ReceiptStore(), settingsStore: SettingsStore())
  }
}

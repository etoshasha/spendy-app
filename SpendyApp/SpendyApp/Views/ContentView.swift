//
//  ContentView.swift
//  SpendyApp
//
//  Created by A B on 01.12.2023.
//

import SwiftUI

struct ContentView: View {
  @StateObject var receiptStore = ReceiptStore()
  @StateObject var settingsStore = SettingsStore()

  var body: some View {
    TabView {
      HomeView(receiptStore: receiptStore, settingsStore: settingsStore)
        .tabItem {
          Image(systemName: "house")
          Text("Home")
        }
      ReceiptTabView(receiptStore: receiptStore, settingsStore: settingsStore)
        .tabItem {
          Image(systemName: "list.bullet.rectangle.fill")
          Text("History")
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

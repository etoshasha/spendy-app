//
//  CurrencyPickerView.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import SwiftUI

struct CurrencyPickerView: View {
  @Binding var pickedCurrency: Currencies

  var body: some View {
    Picker("", selection: $pickedCurrency) {
      ForEach(Currencies.allCases) { currency in
        Text(String(describing: currency))
      }
    }
  }
}

struct CurrencyPickerView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyPickerView(pickedCurrency: .constant(Currencies.idr))
  }
}

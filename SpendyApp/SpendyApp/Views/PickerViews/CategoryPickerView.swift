//
//  CategoryPickerView.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import SwiftUI

struct CategoryPickerView: View {
  @Binding var pickedCategory: Category

  var body: some View {
    Picker("Category", selection: $pickedCategory) {
      ForEach(Category.allCases) { category in
        Text(String(describing: category))
      }
    }
  }
}

struct CategoryPickerView_Previews: PreviewProvider {
  static var previews: some View {
    CategoryPickerView(pickedCategory: .constant(Category.cafe))
  }
}

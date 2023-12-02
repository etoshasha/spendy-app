//
//  CategoryImageView.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import SwiftUI

struct CategotyImageView: View {
  @Binding var receiptCategory: Category
  @Environment(\.colorScheme)
  var colorScheme

  var body: some View {
    Image(receiptCategory.image)
      .resizable()
      .renderingMode(.template)
      .foregroundColor(colorScheme == .dark ? .gray : .black.opacity(0.8))
      .frame(maxWidth: 60, maxHeight: 60)
  }
}

struct CategotyImageView_Previews: PreviewProvider {
  static var previews: some View {
    CategotyImageView(receiptCategory: .constant(Category.clothing))
  }
}

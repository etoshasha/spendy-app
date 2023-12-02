//
//  FileManager.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import Foundation

public extension FileManager {
  static var documentsDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}

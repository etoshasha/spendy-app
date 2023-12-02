//
//  SettingsStore.swift
//  SpendyApp
//
//  Created by A B on 02.12.2023.
//

import Foundation

import SwiftUI

struct Settings: Codable {
  var mainCurrency: Currencies
}

class SettingsStore: ObservableObject {
  enum SettingErrors: String, Error {
    case failedToSaveData = "Error: failed to save data. Try again later"
    case failedToLoadData = "Error: failed to load data. Try again later"
  }

  let settingsJSONURL = FileManager.documentsDirectoryURL
    .appendingPathComponent("Settings")
    .appendingPathExtension("json")

  @Published var edittingSettings = false
  @Published var settings = Settings(
    mainCurrency: .eur) {
      didSet {
        saveSettings()
      }
    }

  init() {
    loadSettings()
  }

  private func loadSettings() {
    guard FileManager.default.fileExists(atPath: settingsJSONURL.path) else {
      return
    }
    let decoder = JSONDecoder()

    do {
      let settingsData = try Data(contentsOf: settingsJSONURL)
      settings = try decoder.decode(Settings.self, from: settingsData)
    } catch {
      print(SettingErrors.failedToLoadData.rawValue)
    }
  }

  private func saveSettings() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
      let settingsData = try encoder.encode(settings)

      try settingsData.write(to: settingsJSONURL, options: .atomic)
    } catch {
      print(SettingErrors.failedToSaveData.rawValue)
    }
  }
}

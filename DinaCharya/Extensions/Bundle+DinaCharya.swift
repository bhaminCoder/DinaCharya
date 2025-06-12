//
//  Bundle+DinaCharya.swift
//  DinaCharya
//
//  Created by Hejib Vinayak (BT: Product Dev. & Eng.: Product Engineering CoE) on 12/06/25.
//

import Foundation

extension Bundle {
    var openAIAPIKey: String? {
        guard let url = self.url(forResource: "AppInfo", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            return nil
        }
        return plist["OPENAI_API_KEY"] as? String
    }
}

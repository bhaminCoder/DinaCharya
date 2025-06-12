//
//  LLMServiceable.swift
//  DinaCharya
//
//  Created by Hejib Vinayak (BT: Product Dev. & Eng.: Product Engineering CoE) on 12/06/25.
//

protocol LLMServiceable {
    func sendChat(messages: [[String: String]], model: String) async throws -> String
}

//
//  LLMAIClient.swift
//  DinaCharya
//
//  Created by Hejib Vinayak (BT: Product Dev. & Eng.: Product Engineering CoE) on 12/06/25.
//

import Foundation
import Combine

final class LLMAIClient: LLMServiceable {
    
    private let endpoint = URL(string: "https://api.openai.com/v1/chat/completions")!

    func sendChat(messages: [[String: String]], model: String = "gpt-4o-mini") async throws -> String {
        guard let openAIAPIKey = Bundle.main.openAIAPIKey else {
            throw NSError(domain: "LLMAIClient", code: 1001, userInfo: [NSLocalizedDescriptionKey : "OpenAI API key not found in bundle."])
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("Bearer \(openAIAPIKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": model,
            "messages": messages
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)

        let json = try JSONSerialization.jsonObject(with: data)
        guard
            let dict = json as? [String: Any],
            let choices = dict["choices"] as? [[String: Any]],
            let message = choices.first?["message"] as? [String: Any],
            let content = message["content"] as? String
        else {
            throw NSError(domain: "Parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse LLM response"])
        }

        return content
    }
}

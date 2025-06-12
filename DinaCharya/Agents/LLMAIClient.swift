//
//  LLMAIClient.swift
//  DinaCharya
//
//  Created by Hejib Vinayak (BT: Product Dev. & Eng.: Product Engineering CoE) on 12/06/25.
//

import Foundation
import Combine

final class LLMAIClient: LLMServiceable {
    
    private let openAIUrlString = "https://api.openai.com/v1/chat/completions"

    // Sends a chat request to the OpenAI API and returns the response content.
    func sendMessage(messages: [[String: String]], model: String) async throws -> String {
        
        guard let request = makeUrlRequest(messages: messages, model: model) else {
            throw NSError(
                domain: "LLMAIClient",
                code: 1001,
                userInfo: [NSLocalizedDescriptionKey : "OpenAI API key not found in bundle."]
            )
        }

        let (data, _) = try await URLSession.shared.data(for: request)

        let json = try JSONSerialization.jsonObject(with: data)
        guard
            let dict = json as? [String: Any],
            let choices = dict["choices"] as? [[String: Any]],
            let message = choices.first?["message"] as? [String: Any],
            let content = message["content"] as? String
        else {
            throw NSError(
                domain: "Parsing",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Failed to parse LLM response"]
            )
        }

        return content
    }
    
    // Creates a URLRequest for the OpenAI API with the provided messages and model.
    private func makeUrlRequest(messages: [[String: String]], model: String) -> URLRequest? {
        
        // TODO: Make sure the OpenAIAPIKey is added into the AppInfo.plist file
        // Generate an API key on "https://platform.openai.com/settings/organization/api-keys"
        guard let openAIAPIKey = Bundle.main.openAIAPIKey,
              let openAIURL = URL(string: openAIUrlString) else {
            return nil
        }
        
        var request = URLRequest(url: openAIURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(openAIAPIKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": model,
            "messages": messages
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        return request
    }
}

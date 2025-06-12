//
//  PromptBuilder.swift
//  DinaCharya
//
//  Created by Hejib Vinayak (BT: Product Dev. & Eng.: Product Engineering CoE) on 12/06/25.
//

import Foundation

struct PromptBuilder {
    
    static func makeMessages(for prompt: String) -> [[String: String]] {
        let systemPrompt = """
        You are a planning assistant. Based on the user's prompt, return a JSON array of steps as strings.

        Examples:
        Input: Plan a healthy morning
        Output: ["Wake up at 6:30AM", "Drink a glass of water", "10 min meditation", "Go for a walk"]

        Input: I want to prepare for iOS interviews
        Output: ["Review Swift fundamentals", "Practice Leetcode daily", "Study iOS architecture patterns", "Mock interviews"]

        Only respond with a valid JSON array of strings.
        """

        return [
            ["role": "system", "content": systemPrompt],
            ["role": "user", "content": prompt]
        ]
    }
}

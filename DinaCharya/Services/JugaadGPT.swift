//
//  AIHandler.swift
//  DinaCharya
//
//  Created by Hejib Vinayak (BT: Product Dev. & Eng.: Product Engineering CoE) on 12/06/25.
//

import Foundation

final class JugaadGPT: ChecklistGenerating {
    
    private let llmService: LLMServiceable

    init(llmService: LLMServiceable = LLMAIClient()) {
        self.llmService = llmService
    }

    func generateChecklist(from prompt: String) async throws -> [String] {
        
        let messages = PromptBuilder.makeMessages(for: prompt)
        
        let response = try await llmService.sendChat(
            messages: messages,
            model: "gpt-4o-mini"
        )

        guard
            let data = response.data(using: .utf8),
            let checklist = try? JSONDecoder().decode([String].self, from: data)
        else {
            throw NSError(domain: "Parsing", code: 1, userInfo: [NSLocalizedDescriptionKey: "Checklist JSON decoding failed"])
        }

        return checklist
    }
}

//
//  ChecklistViewModel.swift
//  DinaCharya
//
//  Created by Hejib Vinayak (BT: Product Dev. & Eng.: Product Engineering CoE) on 12/06/25.
//

import Combine

final class ChecklistViewModel: ObservableObject {
    
    @Published var prompt: String = ""
    @Published var checklist: [ChecklistItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private let checklistAgent: ChecklistGenerating

    enum Intent {
        case generate
        case reset
    }
    
    func trigger(intent: Intent) async {
        switch intent {
        case .generate:
           await generateChecklist()
        case .reset:
            await reset()
        }
    }
    
    init(agent: ChecklistGenerating = JugaadGPT()) {
        self.checklistAgent = agent
    }

    @MainActor
    private func generateChecklist() async {
        isLoading = true
        errorMessage = nil

        do {
            let items = try await checklistAgent.generateChecklist(from: prompt)
            checklist = items.map { ChecklistItem(title: $0) }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    @MainActor
    private func reset() async {
        prompt = ""
        checklist = []
        isLoading = false
        errorMessage = nil
    }
}

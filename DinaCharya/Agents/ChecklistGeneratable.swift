//
//  ChecklistGenerating.swift
//  DinaCharya
//
//  Created by Hejib Vinayak (BT: Product Dev. & Eng.: Product Engineering CoE) on 12/06/25.
//

protocol ChecklistGenerating {
    func generateChecklist(from prompt: String) async throws -> [String]
}

//
//  ChecklistViewModel.swift
//  DinaCharya
//
//  Created by Hejib Vinayak (BT: Product Dev. & Eng.: Product Engineering CoE) on 12/06/25.
//

import Foundation

struct ChecklistItem: Identifiable {
    let id = UUID()
    let title: String
    var isDone: Bool = false
}

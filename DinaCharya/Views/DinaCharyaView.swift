//
//  DinaCharyaView.swift
//  DinaCharya
//
//  Created by Hejib Vinayak (BT: Product Dev. & Eng.: Product Engineering CoE) on 12/06/25.
//

import SwiftUI

struct DinaCharyaView: View {
    
    // Using StateObject to manage the checklist view model
    @StateObject private var viewModel = ChecklistViewModel()

    // MARK: - View Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    logoImage

                    textFieldView
                    
                    buttonView

                    checklistView
                }
                .padding()
            }
            .navigationTitle("Dinacharya")
        }
    }
    
    // MARK: - View Components
    
    // MARK: - Private View Builders
    
    @ViewBuilder
    private var logoImage: some View {
        Image("SwiftCircle_H")
            .resizable()
            .scaledToFit()
            .frame(height: 100)
            .padding(.top, 16)
            .padding(.bottom, 40)
    }
    
    @ViewBuilder
    private var textFieldView: some View {
        TextField("What do you want a plan for?", text: $viewModel.prompt)
            .padding()
            .frame(height: 60)
            .font(.system(size: 20, weight: .medium))
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
            .padding(.horizontal)
            .foregroundStyle(.primary)
    }
    
    @ViewBuilder
    private var buttonView: some View {
        HStack(alignment: .center, spacing: 20.0) {
            Button("Generate Plan") {
                Task { await viewModel.trigger(intent: .generate) }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading || viewModel.prompt.isEmpty)
            
            Button("Refresh everything!") {
                Task { await viewModel.trigger(intent: .reset) }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading || viewModel.prompt.isEmpty)
        }
    }
    
    @ViewBuilder
    private var checklistView: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let error = viewModel.errorMessage {
            Text("Error: \(error)").foregroundColor(.red)
        } else {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach($viewModel.checklist) { $item in
                    HStack {
                        Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                            .onTapGesture { item.isDone.toggle() }
                        Text(item.title)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }
}
